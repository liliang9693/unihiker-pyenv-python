#!/bin/bash
set -eo pipefail

# 预检：检查是否已安装pyenv
PYENV_ROOT="/root/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    echo "检测到已有pyenv安装：$PYENV_ROOT"
    echo "为避免配置冲突，安装流程已终止"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

check_file() {
    if [ ! -f "$1" ]; then
        echo "错误：关键文件 $1 缺失" >&2
        exit 1
    fi
}

# 文件预检
check_file "${SCRIPT_DIR}/offline-repo.tar.gz"
check_file "${SCRIPT_DIR}/pyenv-offline.tar.gz"

# 解压离线仓库
echo "正在部署离线仓库..."
sudo tar xzf "${SCRIPT_DIR}/offline-repo.tar.gz" -C /var/local/  --warning=no-timestamp

# 配置APT源
REPO_LINE="deb [trusted=yes] file:/var/local/offline-repo ./"
if ! grep -qF "$REPO_LINE" /etc/apt/sources.list; then
    echo "$REPO_LINE" | sudo tee -a /etc/apt/sources.list >/dev/null
    echo "已成功添加APT源"
else
    echo "检测到现有APT源配置，跳过添加"
fi

# 更新软件仓库
echo "正在更新软件仓库..."
sudo apt-get update -y

# 批量安装开发工具
echo "正在安装编译依赖..."
sudo apt-get install -y \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev

# 部署pyenv
echo "正在安装pyenv..."
sudo tar xzf "${SCRIPT_DIR}/pyenv-offline.tar.gz" -C /root/ --same-owner  --warning=no-timestamp

# 验证pyenv安装完整性
PYENV_VERSIONS="/root/.pyenv/versions"
echo "正在验证pyenv安装..."
if [ -d "$PYENV_VERSIONS" ]; then
    echo "pyenv目录结构验证通过"
else
    echo "致命错误：pyenv安装不完整，缺失版本目录" >&2
    exit 1
fi

# 修改后的环境配置部分
echo "正在配置pyenv环境..."

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
sleep 2
eval "$(pyenv init --path)"
sleep 2
eval "$(pyenv virtualenv-init -)"
sleep 5
source ~/.bashrc
sleep 3
# 最终验证
echo "执行最终验证..."
if command -v pyenv &>/dev/null; then
    echo "pyenv版本：$(pyenv --version | cut -d' ' -f2)"
    echo "√√√ 环境部署成功 √√√"
else
    echo "错误：pyenv未正确安装" >&2
    exit 1
fi

echo "---"
echo "请输入命令启用 source ~/.bashrc"

