include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-mesh-vpn-wiredigger
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include ../gluon.mk


define Package/gluon-mesh-vpn-wiredigger
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Support for connecting meshes via Wireguard and GRE
  DEPENDS:=+gluon-core +gluon-mesh-vpn-core +libgluonutil +kmod-gre +kmod-gre6 +ip-full +kmod-wireguard +wireguard-tools +kmod-udptunnel6 +kmod-udptunnel4 +kmod-ipt-hashlimit
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
	$(call GluonSrcDiet,./luasrc,$(PKG_BUILD_DIR)/luadest/)
endef

define Package/gluon-mesh-vpn-wiredigger/install
	$(CP) ./files/* $(1)/
	$(CP) $(PKG_BUILD_DIR)/luadest/* $(1)/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/luadest/usr/bin/wiredigger $(1)/usr/bin/
endef

define Package/gluon-mesh-vpn-wiredigger/postinst
#!/bin/sh
$(call GluonCheckSite,check_site.lua)
endef

$(eval $(call BuildPackage,gluon-mesh-vpn-wiredigger))
