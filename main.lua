--本模块由AI自动生成
--将安装包上传到设备中然后安装应用
local apkPath = params.apkFile
local remotePath = "/data/local/tmp/"

local fileName = Path.GetFileName(apkPath)
local remoteApkPath = remotePath .. fileName
if not File.Exists(apkPath) then
    log_error("APK文件不存在: " .. apkPath)
    return false
end

log(remoteApkPath)
log("开始上传APK到设备: " .. remoteApkPath)



if device.file_upload(apkPath, remotePath) then
    log_success("APK上传成功")
   
    local result = device.run_adb("pm install  " .. remoteApkPath)
    if result then
        log_success("应用安装成功")
    else
        log_error("应用安装失败")
    end
else
    log_error("APK上传失败")
end