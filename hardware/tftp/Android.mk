LOCAL_PATH := $(call my-dir)

include $(XIAOMI_CLEAR_VARS)
LOCAL_MODULE := tftp_symlinks
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)

target_combinations := \
    /mnt/vendor/persist/rfs/shared:shared \
    /mnt/vendor/persist/hlos_rfs/shared:hlos \
    /vendor/firmware_mnt:readonly/firmware \
    /vendor/fsg:readonly/vendor/fsg

target_prefixes := \
    mpss \
    adsp \
    slpi \
    cdsp

target_soc := \
    msm

ifeq ($(TARGET_USES_ESOC),true)
  target_soc += \
      mdm

  target_prefixes += \
      tn
endif

# Prepend vendor and prefix directory to all link names:
XIAOMI_SYMLINKS := \
    $(foreach tgtsoc,$(target_soc), \
        $(foreach prefix,$(target_prefixes), \
            $(foreach s,$(target_combinations), \
                $(eval p := $(subst :,$(space),$(s))) \
                $(word 1,$(p)):$(TARGET_COPY_OUT_VENDOR)/rfs/$(tgtsoc)/$(prefix)/$(word 2,$(p)) \
            ) \
        ) \
    )

# Edgecase for readwrite folders that all point to their own persist folder:
XIAOMI_SYMLINKS += \
    $(foreach tgtsoc,$(target_soc), \
        $(foreach prefix,$(target_prefixes), \
            /mnt/vendor/persist/rfs/$(tgtsoc)/$(prefix):$(TARGET_COPY_OUT_VENDOR)/rfs/$(tgtsoc)/$(prefix)/readwrite \
        ) \
    )

# Edgecase for tombstone folders need to follow a different pattern:
XIAOMI_SYMLINKS += \
    $(foreach tgtsoc,$(target_soc), \
        /data/vendor/tombstones/modem:$(TARGET_COPY_OUT_VENDOR)/rfs/$(tgtsoc)/mpss/ramdumps \
        /data/vendor/tombstones/lpass:$(TARGET_COPY_OUT_VENDOR)/rfs/$(tgtsoc)/adsp/ramdumps \
        /data/vendor/tombstones/rfs/cdsp:$(TARGET_COPY_OUT_VENDOR)/rfs/$(tgtsoc)/cdsp/ramdumps \
        /data/vendor/tombstones/rfs/slpi:$(TARGET_COPY_OUT_VENDOR)/rfs/$(tgtsoc)/slpi/ramdumps \
    )

ifeq ($(TARGET_USES_ESOC),true)
  XIAOMI_SYMLINKS += \
      $(foreach tgtsoc,$(target_soc), \
          /data/vendor/tombstones/rfs/tn:$(TARGET_COPY_OUT_VENDOR)/rfs/$(tgtsoc)/tn/ramdumps \
      )
endif

include $(XIAOMI_BUILD_SYMLINKS)
