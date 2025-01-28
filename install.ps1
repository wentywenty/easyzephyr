scoop install git 
scoop install ninja wget uv gh

gh auth login
gh repo clone wentywenty/zephyr
gh repo clone wentywenty/nrfutil

cd zephyr
scoop install ./dtc.json 
scoop install ./gperf.json 
scoop install ../nrfutil/nrfutil.json

uv python install 3.11
uv venv

uv pip install west

west init -m https://github.com/nrfconnect/sdk-nrf

west update

uv pip install -r zephyr/scripts/requirements.txt -r nrf/scripts/requirements.txt -r bootloader/mcuboot/scripts/requirements.txt


