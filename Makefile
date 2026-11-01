# We use the solid 9.3 SDK to compile, but force the deployment target down to iOS 3.0
TARGET = iphone:clang:9.3:3.0
ARCHS = armv7

# LEGACY COMPATIBILITY OVERRIDES:
# -miphoneos-version-min=3.0 forces clang to strip out all modern _objc_alloc lookups!
ADDITIONAL_CFLAGS = -fno-modules -Wno-error -Wno-deprecated-module-dot-map -fobjc-runtime=ios-3.0 -miphoneos-version-min=3.0

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Bloonionaire
Bloonionaire_FILES = RootViewController.m
Bloonionaire_FRAMEWORKS = UIKit CoreGraphics
Bloonionaire_BUNDLE_RESOURCE_DIRS = Resources

include $(THEOS_MAKE_PATH)/application.mk
