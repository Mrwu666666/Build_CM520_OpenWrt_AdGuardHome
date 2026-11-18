
#!/bin/bash
#=================================================

# Description: DIY script for OpenWrt

#=================================================

# 修改默认IP (避免与光猫冲突，设为192.168.10.1)

sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改默认主机名

sed -i 's/OpenWrt/CM520-AdBlock/g' package/base-files/files/bin/config_generate

# 添加Adbyby Plus插件源 (如果feeds.conf.default中未添加)

# 注意：需要在feeds.conf.default中已经添加了kenzo或small源

# 这里确保安装adbyby-plus

echo "Installing Adbyby Plus..."

# 如果在make install feeds之后执行，这里不需要额外操作，只要在.config中选中即可

# 但为了确保规则文件目录存在，可以创建目录

mkdir -p files/etc/adbyby

# 去除MMC/SD相关内核模块的编译选项 (双重保险，防止.config遗漏)

# 在.config中已经设置了 is not set，这里可以通过sed再次确认

sed -i '/CONFIG_PACKAGE_kmod-mmc/d' .config
sed -i '/CONFIG_PACKAGE_kmod-sdhci/d' .config
echo "# CONFIG_PACKAGE_kmod-mmc is not set" >> .config
echo "# CONFIG_PACKAGE_kmod-sdhci is not set" >> .config

# 优化编译选项

sed -i 's/-Os/-O2/g' include/target.mk
sed -i 's/-Os/-O2/g' toolchain/gcc/Config.in

echo "DIY Script Completed."
