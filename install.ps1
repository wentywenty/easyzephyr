Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install git

scoop install ninja wget uv
git clone https://github.com/wentywenty/zephyr.git

scoop install ./dtc.json 
scoop install ./gperf.json 
scoop install ./nrfutil.json

uv python install 3.11
uv venv
# .venv\Scripts\activate       

# uv pip install west

# west init -m https://github.com/nrfconnect/sdk-nrf

# uv pip install -r zephyr/scripts/requirements.txt -r nrf/scripts/requirements.txt -r bootloader/mcuboot/scripts/requirements.txt

# zephyr\zephyr-env.cmd
