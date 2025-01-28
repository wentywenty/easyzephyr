# 一键安装zephyr环境(作者：wentywenty)   

## 使用方法

### 设置执行策略

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 下载并执行安装脚本(依次执行两个部分即可~)

```powershell
(Invoke-WebRequest -Uri "https://raw.githubusercontent.com/wentywenty/zephyr/main/install.ps1").Content | Invoke-Expression
```

## 忘记要Star了，点了再走哦~
