##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION =  a5906c3
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-calvarado2004.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" -C $(@D)/finder-app all
    $(MAKE) CC="$(TARGET_CC)" -C $(@D)/server all
    $(MAKE) CC="$(TARGET_CC)" ARCH=arm64 CROSS_COMPILE=$(TARGET_CROSS) -C $(LINUX_DIR) M=$(@D)/aesd-char-driver modules
endef

# Install commands to place files in the target filesystem
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
    $(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf/
    $(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
    $(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
    $(INSTALL) -D -m 755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/finder.sh
    $(INSTALL) -D -m 755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/tester.sh
    $(INSTALL) -D -m 755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/finder-test.sh
    $(INSTALL) -D -m 755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/writer
    $(INSTALL) -D -m 755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
    $(INSTALL) -D -m 755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
    $(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar.ko $(TARGET_DIR)/lib/modules/$(BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE)
    $(INSTALL) -D -m 755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin/aesdchar_load
    $(INSTALL) -D -m 755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin/aesdchar_unload
endef

$(eval $(generic-package))