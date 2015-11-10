include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = WAReplyPrefs
WAReplyPrefs_FILES = WARRootListController.m
WAReplyPrefs_INSTALL_PATH = /Library/PreferenceBundles
WAReplyPrefs_FRAMEWORKS = UIKit
WAReplyPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/WAReplyPrefs.plist$(ECHO_END)
