# Target is now explicitly forced to ancient iOS 3.0 runtime layout rules
TARGET = iphone:clang:3.0:3.0
ARCHS = armv7

# Strict legacy runtime flag overrides to completely strip modern optimization methods
ADDITIONAL_CFLAGS = -fno-modules -Wno-error -Wno-deprecated-module-dot-map -fobjc-runtime=ios-3.0

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Bloonionaire
Bloonionaire_FILES = RootViewController.m
Bloonionaire_FRAMEWORKS = UIKit CoreGraphics
Bloonionaire_BUNDLE_RESOURCE_DIRS = Resources

include $(THEOS_MAKE_PATH)/application.mk
