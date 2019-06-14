LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := libattr.c attr_copy_fd.c attr_copy_file.c attr_copy_check.c attr_copy_action.c syscalls.c

LOCAL_C_INCLUDES := \
      $(LOCAL_PATH)/ \
      $(LOCAL_PATH)/include \


LOCAL_MODULE := libattr
include $(BUILD_STATIC_LIBRARY)
