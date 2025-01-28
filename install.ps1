安装scoop


安装依赖项
scoop install git 
scoop install ninja wget uv gh

克隆存储库
gh auth login
gh repo clone wentywenty/zephyr

安装依赖包
cd zephyr
scoop install ./dtc.json 
scoop install ./gperf.json 
scoop install ./nrfutil.json

开启虚拟环境
uv python install 3.11

uv venv
.venv\Scripts\activate       

安装sdk
uv pip install west

west init -m https://github.com/nrfconnect/sdk-nrf

west update

west zephyr-export

uv pip install -r zephyr/scripts/requirements.txt -r nrf/scripts/requirements.txt -r bootloader/mcuboot/scripts/requirements.txt

zephyr\zephyr-env.cmd

