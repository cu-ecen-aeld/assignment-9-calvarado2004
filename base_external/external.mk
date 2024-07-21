BR2_EXTERNAL_PROJECT_BASE := $(call qstrip,$(BR2_EXTERNAL_PROJECT_BASE_PATH))

ifeq ($(BR2_PACKAGE_AESD_ASSIGNMENTS),y)
BR2_EXTERNAL_PACKAGES += aesd-assignments
endif
include $(sort $(wildcard $(BR2_EXTERNAL_project_base_PATH)/package/*/*.mk))
