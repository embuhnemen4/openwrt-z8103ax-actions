#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
# ===== Tambahan untuk ZBT-Z8103AX =====

# Copy file DTS dari repo ke folder target DTS OpenWrt
cp -f $GITHUB_WORKSPACE/patches/dts/mt7981-zbtlink-zbt-z8103ax.dts \
    target/linux/mediatek/dts/

# Tambahkan profil device di filogic.mk jika belum ada
grep -q "zbtlink_zbt-z8103ax" target/linux/mediatek/image/filogic.mk || cat >> target/linux/mediatek/image/filogic.mk << 'EOF'

define Device/zbtlink_zbt-z8103ax
  DEVICE_VENDOR := Zbtlink
  DEVICE_MODEL := ZBT-Z8103AX
  DEVICE_DTS := mt7981-zbtlink-zbt-z8103ax
  DEVICE_PACKAGES := kmod-mt7981-firmware wpad-basic-wolfssl
endef
TARGET_DEVICES += zbtlink_zbt-z8103ax
EOF
