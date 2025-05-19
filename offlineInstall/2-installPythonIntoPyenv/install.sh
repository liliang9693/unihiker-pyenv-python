#!/bin/bash

# 设置正确的pyenv环境变量
export PYENV_ROOT="/root/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# 获取脚本所在目录
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# 查找Python安装包
python_tar=$(find "$script_dir" -maxdepth 1 -name 'python-3.*.tar.gz' | head -n 1)

# 检查安装包是否存在
if [ -z "$python_tar" ]; then
    echo "错误：在脚本目录未找到python-3.x.x.tar.gz安装包"
    exit 1
fi

# 检查目标目录是否存在
versions_dir="$PYENV_ROOT/versions"
if [ ! -d "$versions_dir" ]; then
    echo "错误：目标目录 $versions_dir 不存在"
    exit 1
fi

# 获取安装前的版本列表
old_versions=$(pyenv versions --bare)

echo "当前Python版本: $old_versions "

# 从文件名提取版本号
version=$(basename "$python_tar" .tar.gz | sed 's/^python-//')

# 创建版本目录并解压
target_dir="$versions_dir/$version"

# 检查是否已存在
if [ -d "$target_dir" ]; then
    echo "错误：Python版本 $version 已存在于 $target_dir，停止安装。"
    exit 1
fi


mkdir -p "$target_dir"
echo "正在安装Python $version 到 $target_dir..."

if ! tar -xzf "$python_tar" -C "$target_dir" --strip-components=1  --warning=no-timestamp; then
    echo "错误：解压安装包失败"
    rm -rf "$target_dir"
    exit 1
fi

# 执行pyenv更新
pyenv rehash

# 获取安装后的版本列表
new_versions=$(pyenv versions --bare)

# 比较版本差异
if ! grep -q "^$version\$" <<< "$new_versions"; then
    echo "错误：新版本 $version 未成功安装"
    exit 1
fi

# 检查是否为新增版本
if grep -q "^$version\$" <<< "$old_versions"; then
    echo "检测到已存在的Python版本: $version"
    exit 0
else
    echo "成功安装新的Python版本: $version"
    echo "当前所有可用版本:"
    pyenv versions
    
    exit 0
fi

echo "使用 pyenv versions 列出可用版本"
echo "使用 pyenv global <版本号> 切换版本"