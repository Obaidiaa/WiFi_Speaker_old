include $(TOPDIR)/rules.mk

PKG_NAME:=luci-airspeaker
PKG_VERSION:=1.0.0
SOURCE_DIR:=./src

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=LuCI
  CATEGORY:=Obaidiaa
  SUBMENU:=AirSpeaker
  TITLE:=Luci shirprot-sync
endef

define Package/$(PKG_NAME)/description
LuCi AirSpeaker package.
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/airspeaker
endef

define Package/$(PKG_NAME)/install
        $(CP) $(SOURCE_DIR)/* $(1)
endef

define Package/$(PKG_NAME)/postinst
endef

define Package/$(PKG_NAME)/prerm
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
