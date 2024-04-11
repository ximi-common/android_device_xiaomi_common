ifeq ($(PRODUCT_PLATFORM_XIMI),true)
  LOCAL_PATH := $(call my-dir)
  include $(call all-subdir-makefiles)
endif
