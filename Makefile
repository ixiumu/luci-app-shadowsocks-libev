include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-shadowsocks-libev
PKG_VERSION=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-shadowsocks-libev
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=shadowsocks-libev for LuCI
	PKGARCH:=all
endef

define Package/luci-app-shadowsocks-libev/description
	Shadowsocks-libev is a lightweight secured scoks5 proxy for embedded devices and low end boxes.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-shadowsocks-libev/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	
	$(INSTALL_CONF) ./files/etc/config/shadowsocks $(1)/etc/config/shadowsocks
	$(INSTALL_BIN) ./files/etc/init.d/shadowsocks $(1)/etc/init.d/shadowsocks
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/shadowsocks.lua $(1)/usr/lib/lua/luci/model/cbi/shadowsocks.lua
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/shadowsocks-libev.lua $(1)/usr/lib/lua/luci/controller/shadowsocks-libev.lua
endef

$(eval $(call BuildPackage,luci-app-shadowsocks-libev))