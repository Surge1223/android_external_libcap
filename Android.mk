# Copyright (C) 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)

libcap_src_files := \
    libcap/_makenames.c \
    libcap/cap_alloc.c \
    libcap/cap_extint.c \
    libcap/cap_file.c \
    libcap/cap_flag.c \
    libcap/cap_proc.c \
    libcap/cap_text.c

libcap_cflags := -Wno-unused-parameter -Wno-tautological-compare -std=gnu89 -DHAVE_CONFIG_H
libattr_dir := $(LOCAL_PATH)/libattr

libattr_src_files := \
	$(libattr_dir)/libattr.c \
	$(libattr_dir)/attr_copy_fd.c \
	$(libattr_dir)/attr_copy_file.c \
	$(libattr_dir)/attr_copy_check.c \
	$(libattr_dir)/attr_copy_action.c \
	$(libattr_dir)/syscalls.c

libattr_cflag := \
	-g -O2 -DDEBUG -funsigned-char \
	-fno-strict-aliasing -Wall \
	-DVERSION=\"2.4.47\" \
	-DPACKAGE=\"attr\" \
	-D_GNU_SOURCE \
	-D_FILE_OFFSET_BITS=64

common_includes := \
	$(LOCALPATH) \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/../include \
	$(libattr_dir)/../include \
	libcap/include

include $(CLEAR_VARS)

LOCAL_CLANG := true
LOCAL_CFLAGS := $(libattr_cflags) -std=gnu89
LOCAL_SRC_FILES := $(libattr_src_files)
LOCAL_MODULE := libattr_static

LOCAL_C_INCLUDES := \
      $(libattr_dir)/ \
     	$(LOCAL_PATH)/../include \

LOCAL_MODULE_FILENAME := libattr
LOCAL_C_INCLUDES += $(LOCAL_PATH)/include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/libattr/include
include $(BUILD_STATIC_LIBRARY)

# Shared library.
include $(CLEAR_VARS)
LOCAL_CLANG := true
LOCAL_CFLAGS := $(libcap_cflags)
LOCAL_SRC_FILES := $(libcap_src_files)

LOCAL_C_INCLUDES += $(LOCAL_PATH)/libcap/include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/libcap/include
LOCAL_MODULE := libcap_static
include $(BUILD_STATIC_LIBRARY)

##
# getcap
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	progs/getcap.c

LOCAL_MODULE := getcap
LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := $(common_cflags)
LOCAL_STATIC_LIBRARIES :=  libcap_static
LOCAL_LDFLAGS += -static
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_PACK_MODULE_RELOCATIONS := false

include $(BUILD_EXECUTABLE)

##
# setcap
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	progs/setcap.c

LOCAL_MODULE := setcap
LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := $(common_cflags)
LOCAL_STATIC_LIBRARIES :=  libcap_static libcap_static
LOCAL_LDFLAGS += -static
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_PACK_MODULE_RELOCATIONS := false

include $(BUILD_EXECUTABLE)

##
# capsh
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	progs/capsh.c

LOCAL_MODULE := capsh
LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := $(common_cflags)
LOCAL_STATIC_LIBRARIES :=  libcap_static libcap_static
LOCAL_LDFLAGS += -static
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_PACK_MODULE_RELOCATIONS := false
include $(BUILD_EXECUTABLE)

##
# getpcaps
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	progs/getpcaps.c

LOCAL_MODULE := getpcaps
LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := $(common_cflags)

LOCAL_STATIC_LIBRARIES :=  libcap_static libattr_static
LOCAL_LDFLAGS += -static
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_PACK_MODULE_RELOCATIONS := false

include $(BUILD_EXECUTABLE)
