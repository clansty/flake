# Yoga Slim 7 Carbon

## 修复关机之后自动开机的问题

首先需要一个 [UniversalAMDFormBrowser](https://github.com/DavidS95/Smokeless_UMAF)，./umaf.nix 可以安装它

然后关闭 AMD PBS -> Wake on PME

## 修复开机时候的 ACPI Error

开启 AMD PBS -> Reduced device support

## 关于 S3 睡眠的尝试

在 UMAF 里打开 S3 之后也会解决自动开机的问题，但是进系统之后无论用 deep 还是 s2idle 睡眠都有问题

s2idle 睡眠不会熄灭电源灯和 FnLock 灯。不开 S3 的时候可以的

deep 睡眠在 dmesg 里可以看到进入睡眠状态（CPU 关闭）之后过了 0.1 秒立马就又被唤醒了，但是屏幕还是黑的。更严重的问题是，按键盘唤醒屏幕之后过了大概三十秒会机器会 reset

AMD PBS 设置成 Modern Standby 的时候用 s2idle 睡眠没有问题，功耗大概 3W 左右，已经很好了。
