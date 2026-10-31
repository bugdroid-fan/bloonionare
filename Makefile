TARGET = iphone:clang:9.3:9.3
ARCHS = armv7

# Turns off modules and silences strict modern warnings across all precompiled headers
ADDITIONAL_CFLAGS = -fno-modules -Wno-error -Wno-deprecated-module-dot-map

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Bloonionaire
Bloonionaire_FILES = RootViewController.m
Bloonionaire_FRAMEWORKS = UIKit CoreGraphics
Bloonionaire_RESOURCES = Resources

include $(THEOS_MAKE_PATH)/application.mk
