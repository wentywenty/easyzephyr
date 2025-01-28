Write-Host "`n欢迎使用一键安装zephyr脚本,人生苦短,快用一键安装~" -ForegroundColor Green
Write-Host "`n作者:Github:wentywenty" -ForegroundColor Green
Write-Host "`n版本:v1.0" -ForegroundColor Green

Write-Host "`n正在检查并安装 Scoop 包管理器..." -ForegroundColor Green
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "`n请选择scoop安装位置" -ForegroundColor Green
    # 设置 Scoop 安装路径
    $SCOOP_ROOT = "$env:USERPROFILE\scoop"
    Write-Host "Scoop 将安装到: $SCOOP_ROOT" -ForegroundColor Yellow

    # 设置 Scoop 环境变量
    [Environment]::SetEnvironmentVariable('SCOOP', $SCOOP_ROOT, 'User')
    [Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', "$env:ProgramData\scoop", 'Machine')
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}
else {
    Write-Host "`nScoop 已安装..." -ForegroundColor Yellow
    scoop bucket add extras
}

Write-Host "正在更新Scoop..." -ForegroundColor Yellow
scoop update *

Write-Host "`n正在安装基础开发工具..." -ForegroundColor Green
scoop install git
scoop install ninja wget uv cmake

Write-Host "`n正在克隆 Zephyr 仓库..." -ForegroundColor Green
if (!(Test-Path "zephyr")) {
    git clone https://github.com/wentywenty/zephyr.git
}
else {
    Write-Host "Zephyr 目录已存在，跳过克隆..." -ForegroundColor Yellow
}

Set-Location zephyr

Write-Host "`n正在安装编译工具..." -ForegroundColor Green
scoop install ./dtc.json 
scoop install ./gperf.json 
scoop install ./nrfutil.json

Write-Host "`n正在配置 Python 环境..." -ForegroundColor Green
uv python install 3.11
uv venv
Write-Host "正在激活虚拟环境..." -ForegroundColor Green
.venv\Scripts\activate       

Write-Host "`n正在安装 Zephyr 开发环境..." -ForegroundColor Green
uv pip install west

Write-Host "`n初始化 West 工作区..." -ForegroundColor Green
west init -m https://github.com/nrfconnect/sdk-nrf --mr v2.9.0

Write-Host "`n正在更新 West..." -ForegroundColor Green
Write-Host "这可能需要一段时间，请保持网络稳定..." -ForegroundColor Yellow
west update

Write-Host "`n安装项目依赖..." -ForegroundColor Green
uv pip install -r zephyr/scripts/requirements.txt -r nrf/scripts/requirements.txt -r bootloader/mcuboot/scripts/requirements.txt

Write-Host "`n配置 West Cmake环境..." -ForegroundColor Yellow
west zephyr-export

Write-Host "`n配置 Zephyr 环境变量..." -ForegroundColor Green
.\zephyr\zephyr-env.cmd

# 安装nRF工具
Write-Host "`n正在安装 nRF 开发工具..." -ForegroundColor Green
Write-Host "安装 BLE Sniffer..." -ForegroundColor Yellow
nrfutil install ble-sniffer

Write-Host "安装工具链管理器..." -ForegroundColor Yellow
nrfutil install toolchain-manager

Write-Host "配置工具链安装目录..." -ForegroundColor Yellow
nrfutil toolchain-manager config --set install-dir=.

Write-Host "安装 nRF Connect SDK v2.9.0..." -ForegroundColor Yellow
nrfutil toolchain-manager install --ncs-version v2.9.0

Write-Host "安装 jlink,请手动访问" -ForegroundColor Yellow
Write-Host "https://www.segger.com/downloads/jlink/JLink_Windows_x86_64.exe" -ForegroundColor Yellow
