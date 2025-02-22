#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP and password
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改连接数
# sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
# 修正连接数
sed -i '$a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf
# 修复 libpcre (临时)
# sed -i 's/+libpcre/+libpcre2/g' feeds/telephony/net/freeswitch/Makefile
# ./scripts/feeds install -a

# themes添加（svn co 命令意思：指定版本如https://github）
# git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
# git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
# git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/jerrykuku/luci-theme-argon.git --depth=1 package/luci-theme-argon

# 添加额外软件包
# git clone https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata
git clone https://github.com/vernesong/OpenClash.git --depth=1 package/OpenClash
git clone https://github.com/kenzok78/luci-app-adguardhome.git --depth=1 package/luci-app-adguardhome
git clone https://github.com/hyperlook/luci-app-openvpn-server --depth=1 package/luci-app-openvpn-server
# git clone https://github.com/jerrykuku/luci-app-argon-config --depth=1 package/luci-app-argon-config


# 添加核心温度的显示
# sed -i 's|pcdata(boardinfo.system or "?")|luci.sys.exec("uname -m") or "?"|g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
# sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# Modify NTP Server
sed -i "s/0.openwrt.pool.ntp.org/ntp.aliyun.com/g" package/base-files/files/bin/config_generate
sed -i "s/1.openwrt.pool.ntp.org/cn.ntp.org.cn/g" package/base-files/files/bin/config_generate
sed -i "s/2.openwrt.pool.ntp.org/cn.pool.ntp.org/g" package/base-files/files/bin/config_generate
