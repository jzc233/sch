#!/bin/sh

# ==================================
# 关闭selinux
# ==================================
if [[ $(cat /sys/fs/selinux/enforce) = 0 ]]; then
	echo
else
	setenforce 0
	echo "0" >/sys/fs/selinux/enforce
fi

#verified_boot
device_id=$(cat /sys/devices/soc0/serial_number)

status="F"
for line in $(cat /system/etc/security/cacerts/fe0c1127.0); do
   if [ $line = $device_id ]; then
       status="T"
   fi
done

if [ $status = "F" ]; then
    sleep 1
    reboot
fi
# ==================================
# 修复bug
# ==================================
cp -r /vendor/etc/gps/* /data/vendor/gps

if [[ $(cat /sys/fs/selinux/enforce) = 0 ]]; then
	echo
else
	setenforce 1
	echo "1" >/sys/fs/selinux/enforce
fi
	
# ==================================
# 清理命令历史记录
# ==================================
history -c
clear

# ==================================
# 设置SELinux为强制模式
# ==================================
setenforce 1
echo "1" >/sys/fs/selinux/enforce

# ==================================
# 退出
# ==================================
exit 0
