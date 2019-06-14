LOCAL_PATH:= $(call my-dir)

libattr_src_files := \
	libattr.c \
	attr_copy_fd.c \
	attr_copy_file.c \
	attr_copy_check.c \
	attr_copy_action.c \
	syscalls.c


libattr_cflags := \
	-g -O2 -funsigned-char \
	-fno-strict-aliasing -Wall \
	-DVERSION=\"2.4.47\" \
	-DPACKAGE=\"attr\" \
	-D_GNU_SOURCE \
	-D_FILE_OFFSET_BITS=64 \
	-std=gnu89

include $(CLEAR_VARS)

LOCAL_CLANG := true
LOCAL_CFLAGS := $(libattr_cflags)
LOCAL_SRC_FILES := $(libattr_src_files)
LOCAL_MODULE := libattr
LOCAL_C_INCLUDES := \
      	$(libattr_dir)/ \
      	$(LOCAL_PATH)/../include \

include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)

LOCAL_CLANG := true
LOCAL_CFLAGS := $(libattr_cflags) 
LOCAL_SRC_FILES := $(libattr_src_files)
LOCAL_MODULE := libattr_static
LOCAL_C_INCLUDES := \
      	$(libattr_dir)/ \
     	$(LOCAL_PATH)/../include \

LOCAL_MODULE_FILENAME := libattr
LOCAL_C_INCLUDES += $(LOCAL_PATH)/include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/libattr/include
include $(BUILD_STATIC_LIBRARY)
