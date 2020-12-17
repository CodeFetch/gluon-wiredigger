include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-mesh-wiredigger
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/gluon-mesh-wiredigger
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=gluon-mesh-wiredigger
  DEPENDS:=+gluon-core +micrond +kmod-gre +ip-full +kmod-wireguard +wireguard-tools +kmod-udptunnel6 +kmod-udptunnel4 +kmod-ipt-hashlimit
endef

define Build/Prepare
        mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-mesh-wiredigger/install
        $(CP) ./files/* $(1)/
	$(call GluonInstallI18N,gluon-mesh-wiredigger,$(1))
endef

$(eval $(call BuildPackage,gluon-mesh-wiredigger))

