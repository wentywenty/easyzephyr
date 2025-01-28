# Zephyr 开发环境配置指南

## 1.基础环境配置

### 1.1 安装包管理器 Scoop

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Invoke-RestMethod -Uri "https://example.com/script.ps1" | Invoke-Expression


> 此命令修改 PowerShell 的执行策略，允许运行本地脚本文件。`RemoteSigned` 要求所有从网络下载的脚本必须由受信任的发布者签名。

```powershell

Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

> 下载并执行 Scoop 安装脚本。Scoop 是 Windows 下的命令行包管理器，类似于 Linux 下的 apt 或 yum。

### 1.2 安装基础工具

```powershell
scoop install git
```

> 安装 Git 版本控制系统。

```powershell
scoop bucket add extras
```

> 添加额外的 Scoop 存储桶，用于安装其他软件包。

```powershell
scoop install ninja wget uv gh
```

> - ninja: 高性能的构建系统
> - wget: 命令行下载工具
> - uv: 现代化 Python 包管理器和虚拟环境工具
> - gh: GitHub 的官方命令行工具

### 1.3 获取源代码

```powershell
gh auth login
```

> 登录 GitHub 账号，这将引导你完成身份验证过程。

```powershell
gh repo clone wentywenty/zephyr
```

> 克隆 Zephyr 项目仓库到本地。

### 1.4. 安装开发工具

```powershell
cd zephyr
```

> 进入克隆的 Zephyr 项目目录。

```powershell
scoop install ./dtc.json
```

> 安装设备树编译器(Device Tree Compiler)，用于编译设备树源文件。

```powershell
scoop install ./gperf.json
```

> 安装 GNU perfect hash 生成器，用于生成完美哈希函数。

```powershell
scoop install ./nrfutil.json
```

> 安装 Nordic nRF 命令行工具，用于与 Nordic 设备进行交互。

## 2. 配置zephyr环境

### 2.1. 配置 Python 环境

```powershell
uv python install 3.11
```

> 使用 uv 工具安装 Python 3.11 版本。

```powershell
uv venv
```

> 创建 Python 虚拟环境，隔离项目依赖。

```powershell
.venv\Scripts\activate
```

> 激活 Python 虚拟环境，后续的 Python 包安装都将在此环境中进行。

### 2.2. 安装 Zephyr SDK

```powershell
uv pip install west
```

> 安装 West 工具，这是 Zephyr 项目的元工具，用于管理多仓库项目。

```powershell
west init -m https://github.com/nrfconnect/sdk-nrf
```

> 初始化 West 工作区，使用 nRF Connect SDK 作为主清单仓库。

```powershell
west update
```

> 更新工作区中的所有项目，下载所需的代码仓库。

### 2.3 配置zephyr依赖

```powershell
west zephyr-export
```

> 导出 Zephyr CMake 包，设置构建环境。

```powershell
uv pip install -r zephyr/scripts/requirements.txt -r nrf/scripts/requirements.txt -r bootloader/mcuboot/scripts/requirements.txt
```

> 安装 Zephyr、nRF SDK 和 MCUboot 所需的所有 Python 依赖包。

### 2.4 配置zephyr环境变量

```powershell
zephyr\zephyr-env.cmd
```

> 设置 Zephyr 开发所需的环境变量。

完成以上步骤后，Zephyr 开发环境就配置完成了，可以开始进行 Nordic nRF 设备的开发工作。

### 2.5 配置工具链

```powershell
west config build.toolchain_variant zephyr
```
