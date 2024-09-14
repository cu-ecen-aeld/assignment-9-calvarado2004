################################################################################
#
# ldd Makefile for Buildroot
#
################################################################################

LDD_VERSION = 4beaa26
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-calvarado2004.git
LDD_INSTALL_TARGET = YES
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

LDD_MODULE_SUBDIRS = scull
LDD_MODULE_SUBDIRS += misc-modules

define LDD_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" -C $(@D)/scull all
    $(MAKE) CC="$(TARGET_CC)" -C $(@D)/misc-modules all
endef

define LDD_INSTALL_TARGET_CMDS
    $(INSTALL) -d 0755 $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)
    $(INSTALL) -m 0755 $(@D)/scull/scull.ko $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE)
    $(INSTALL) -m 0755 $(@D)/misc-modules/faulty.ko $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE)
    $(INSTALL) -m 0755 $(@D)/misc-modules/hello.ko $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE)
    PATH=$(TARGET_DIR)/sbin:$(TARGET_DIR)/bin depmod -a -b $(TARGET_DIR) $(BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE)

endef

$(eval $(kernel-module))
$(eval $(generic-package))
