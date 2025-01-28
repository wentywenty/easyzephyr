# 一键安装(忘记要Star了，点了再走哦~)

## 使用方法

### 设置执行策略

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 下载并执行安装脚本

```powershell
Invoke-RestMethod -Uri "https://raw.githubusercontent.com/wentywenty/zephyr/main/install.ps1" | Invoke-Expression
```
