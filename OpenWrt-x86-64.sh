  
#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# 定制默认IP
sed -i 's/192.168.1.1/10.10.10.233/g' package/base-files/files/bin/config_generate

# 替换默认Argon主题
#rm -rf package/lean/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
#git cloen https://github.com/Aslin-Ameng/luci-theme-Light.git package/luci-theme-Light
#git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat

# 添加第三方软件包
git clone https://github.com/KFERMercer/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/kang-mk/luci-app-smartinfo package/luci-app-smartinfo
git clone https://github.com/Lienol/openwrt-package.git package/openwrt-package
#git clone https://github.com/Flowers-in-thorns/my.git package/Flowers-in-thorns
#git clone https://github.com/Leo-Jo-My/luci-app-ssr-plus-Jo package/luci-app-ssr-plus-Jo
#git clone https://github.com/Flowers-in-thorns/luci-app-vssr-coexist.git package/luci-app-vssr-coexist
git clone https://github.com/Leo-Jo/luci-app-vssr-coexist package/luci-app-vssr-coexist
git clone https://github.com/pymumu/smartdns.git package/smartdns

# uci-app-diskman
#git clone https://github.com/lisaac/luci-lib-docker.git package/luci-lib-docker
#git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
#git clone https://github.com/lisaac/luci-app-diskman package/luci-app-diskman
#mkdir -p package/parted && cp -i package/luci-app-diskman/Parted.Makefile package/parted/Makefile



#创建自定义配置文件 - OpenWrt-x86-64

rm -f ./.config*
touch ./.config

#
# ========================固件定制部分========================
# 

# 
# 如果不对本区块做出任何编辑, 则生成默认配置固件. 
# 

# 以下为定制化固件选项和说明:
#

#
# 有些插件/选项是默认开启的, 如果想要关闭, 请参照以下示例进行编写:
# 
#          =========================================
#         |  # 取消编译VMware镜像:                   |
#         |  cat >> .config <<EOF                   |
#         |  # CONFIG_VMDK_IMAGES is not set        |
#         |  EOF                                    |
#          =========================================
#

# 
# 以下是一些提前准备好的一些插件选项.
# 直接取消注释相应代码块即可应用. 不要取消注释代码块上的汉字说明.
# 如果不需要代码块里的某一项配置, 只需要删除相应行.
#
# 如果需要其他插件, 请按照示例自行添加.
# 注意, 只需添加依赖链顶端的包. 如果你需要插件 A, 同时 A 依赖 B, 即只需要添加 A.
# 
# 无论你想要对固件进行怎样的定制, 都需要且只需要修改 EOF 回环内的内容.
# 

# 编译x64固件:
cat >> .config <<EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
EOF

# 设置固件大小:
#cat >> .config <<EOF
#CONFIG_TARGET_KERNEL_PARTSIZE=30
#CONFIG_TARGET_ROOTFS_PARTSIZE=200
#EOF

# 固件压缩:
cat >> .config <<EOF
CONFIG_TARGET_IMAGES_GZIP=y
EOF

# 编译UEFI固件:
cat >> .config <<EOF
#CONFIG_EFI_IMAGES=y
EOF

# IPv6支持:
cat >> .config <<EOF
#CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
#CONFIG_PACKAGE_ipv6helper=y
EOF

# 多文件系统支持:
cat >> .config <<EOF
CONFIG_PACKAGE_kmod-fs-nfs=y
CONFIG_PACKAGE_kmod-fs-nfs-common=y
CONFIG_PACKAGE_kmod-fs-nfs-v3=y
CONFIG_PACKAGE_kmod-fs-nfs-v4=y
CONFIG_PACKAGE_kmod-fs-ntfs=y
CONFIG_PACKAGE_kmod-fs-squashfs=y
EOF

# USB3.0支持:
cat >> .config <<EOF
CONFIG_PACKAGE_kmod-usb-ohci=y
CONFIG_PACKAGE_kmod-usb-ohci-pci=y
CONFIG_PACKAGE_kmod-usb2=y
CONFIG_PACKAGE_kmod-usb2-pci=y
CONFIG_PACKAGE_kmod-usb3=y
EOF

# 第三方插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-serverchan=y
CONFIG_PACKAGE_luci-app-adguardhome=y
CONFIG_PACKAGE_luci-app-smartinfo=y
CONFIG_PACKAGE_luci-app-smartdns=y
EOF

# ShadowsocksR插件:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-ssr-plus=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Simple_obfs=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_V2ray_plugin=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_V2ray=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Trojan=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Kcptun=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Server=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Socks=y
EOF

# 常用LuCI插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-acme=y
CONFIG_PACKAGE_luci-app-transmission=y
CONFIG_PACKAGE_luci-app-qbittorrent=y
CONFIG_PACKAGE_luci-app-xlnetacc=y
CONFIG_PACKAGE_luci-app-zerotier=y
CONFIG_PACKAGE_luci-app-adbyby-plus=y
CONFIG_PACKAGE_luci-app-v2ray-server=y
CONFIG_PACKAGE_luci-app-pptp-server=y
CONFIG_PACKAGE_luci-app-ipsec-vpnd=y
CONFIG_PACKAGE_luci-app-softethervpn=y
CONFIG_PACKAGE_luci-app-haproxy-tcp=y
CONFIG_PACKAGE_luci-app-webadmin=y
CONFIG_PACKAGE_luci-app-frpc=y
CONFIG_PACKAGE_luci-app-wrtbwmon=y
CONFIG_PACKAGE_luci-app-hd-idle=y
#CONFIG_PACKAGE_luci-app-ssr-plus-Jo=y
CONFIG_PACKAGE_luci-app-mwan3helper=y
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-filetransfer=y
CONFIG_PACKAGE_luci-app-unblockmusic=y
CONFIG_PACKAGE_luci-app-netdata=y
CONFIG_PACKAGE_luci-app-vssr-coexist=y
#CONFIG_PACKAGE_luci-app-docker=y
#CONFIG_PACKAGE_luci-lib-docker=y
CONFIG_PACKAGE_luci-app-dockerman=y
#CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-aria2=y
#CONFIG_PACKAGE_luci-app-samba4=y
#CONFIG_PACKAGE_luci-app-minidlna=y
CONFIG_LUCI_LANG_zh-tw=y
CONFIG_LUCI_LANG_en=y
EOF

# Configuration PASSWALL
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ipt2socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_kcptun=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_haproxy=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ChinaDNS_NG=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_pdnsd=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_dns2socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_v2ray-plugin=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_simple-obfs=y
EOF

# LuCI主题:
cat >> .config <<EOF
#CONFIG_PACKAGE_luci-theme-argon=y
#CONFIG_PACKAGE_luci-theme-Light=y
#CONFIG_PACKAGE_luci-theme-atmaterial=y
CONFIG_PACKAGE_luci-theme-opentomcat=y
EOF

# 常用软件包:
cat >> .config <<EOF
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_screen=y
CONFIG_PACKAGE_tree=y
CONFIG_PACKAGE_vim-fuller=y
CONFIG_PACKAGE_wget=y
EOF

# 取消编译VMware镜像以及镜像填充 (不要删除被缩进的注释符号):
cat >> .config <<EOF
CONFIG_TARGET_IMAGES_PAD=y
CONFIG_VMDK_IMAGES=y
EOF

# 
# ========================固件定制部分结束========================
# 


sed -i 's/^[ \t]*//g' ./.config

# 配置文件创建完成
