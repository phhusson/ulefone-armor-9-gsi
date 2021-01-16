#!/bin/bash

simg2img "$1" s.img || cp -f "$1" s.img
umount d
mkdir -p d
e2fsck -y -f s.img
resize2fs s.img 3500M
e2fsck -E unshare_blocks -y -f s.img
mount -o loop,rw s.img d

cp files/Endoscope.apk d/system/app/Endoscope.apk
xattr -w security.selinux u:object_r:system_file:s0 d/system/app/Endoscope.apk

cp files/MyFLIR.apk d/system/app/MyFLIR.apk
xattr -w security.selinux u:object_r:system_file:s0 d/system/app/MyFLIR.apk

cp files/LeptonCameraService.rc d/system/etc/init/LeptonCameraService.rc
xattr -w security.selinux u:object_r:system_file:s0 d/system/etc/init/LeptonCameraService.rc

cp files/leptonServer d/system/bin/leptonServer
xattr -w security.selinux u:object_r:lepton_exec:s0 d/system/bin/leptonServer

cp files/libleptoncamera.so d/system/lib64/libleptoncamera.so
xattr -w security.selinux u:object_r:system_lib_file:s0 d/system/lib64/libleptoncamera.so

echo 'LeptonCameraService  u:object_r:lepton_service:s0' >> d/system/etc/selinux/plat_service_contexts

echo persist.sys.fflag.override.settings_fuse=false >> d/system/build.prop
echo persist.sys.fuse=false >> d/system/build.prop

umount d
e2fsck -f -y s.img || true
resize2fs -M s.img

