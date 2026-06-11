PROJECT := RecipeHub.xcodeproj
SCHEME := RecipeHub
CONFIGURATION ?= Debug
DERIVED_DATA := .build/DerivedData
IOS_DERIVED_DATA := .build/DerivedData-iOS
BUNDLE_ID := com.alfort106.RecipeHub
IOS_APP_PATH := $(IOS_DERIVED_DATA)/Build/Products/$(CONFIGURATION)-iphoneos/$(SCHEME).app
DEVICE ?=

-include Makefile.local

.PHONY: build ios-build ios-devices ios-install ios-run require-device clean

build:
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-destination 'generic/platform=macOS' \
		-derivedDataPath $(DERIVED_DATA) \
		CODE_SIGNING_ALLOWED=NO \
		build

ios-build:
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-destination 'generic/platform=iOS' \
		-derivedDataPath $(IOS_DERIVED_DATA) \
		build

ios-devices:
	xcrun devicectl list devices

require-device:
ifndef DEVICE
	$(error DEVICE is required. Run "make ios-devices", then use "make ios-run DEVICE=<id-or-name>")
endif

ios-install: require-device ios-build
	xcrun devicectl device install app \
		--device '$(DEVICE)' \
		'$(IOS_APP_PATH)'

ios-run: ios-install
	xcrun devicectl device process launch \
		--device '$(DEVICE)' \
		--terminate-existing \
		$(BUNDLE_ID)

clean:
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-derivedDataPath $(DERIVED_DATA) \
		clean
