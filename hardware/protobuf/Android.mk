LOCAL_PATH := $(call my-dir)

include $(XIAOMI_CLEAR_VARS)
LOCAL_MODULE := protobuf_symlinks
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)

XIAOMI_SYMLINKS += \
    /vendor/lib64/libprotobuf-cpp-full-3.9.1.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libprotobuf-cpp-lite-3.9.1.so
include $(XIAOMI_BUILD_SYMLINKS)
