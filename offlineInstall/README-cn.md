# 说明

在行空板上离线安装pyenv和python版本的方法，针对网络环境不好的情况。

测试环境：行空板V0.4.0系统

# 使用方法
> 注：需已经将1-OfflineInstallPyenv和2-installPythonIntoPyenv上传到行空板root目录。

## 安装pyenv

以下在行空板终端运行

- 进入文件夹路径，运行sh脚本，等待执行完成

  ```
  cd /root/1-OfflineInstallPyenv/
  bash install.sh
  ```

- 启用pyenv

  ```
  source ~/.bashrc
  ```

- 有版本输出即为安装完成

    ``` bash
    pyenv --version
    ```

- 查看当前pyenv环境下可切换的python版本

  ```
  pyenv rehash
  pyenv versions
  ```

  

## 安装Python

以下在行空板终端运行

- 进入文件夹路径，运行sh脚本，等待执行完成

    ```
    cd /root/2-installPythonIntoPyenv/
    bash install.sh
    ```

- 查看当前环境下可切换的python版本

  ```
  pyenv rehash
  pyenv versions
  
  ```

- 切换版本，以3.11.4

    ```
    pyenv global 3.11.4
    python --version
    
    ```

- 切换会系统默认版本

    ```
    pyenv global system
    python --version
    
    ```

    