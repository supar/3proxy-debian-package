.PONY: build

# Package
PACKAGE = 3proxy
PACKAGE_SOURCE = https://github.com/z3APA3A/3proxy/archive/

# Package main version
VERSION = $(firstword $(subst -, ,$(shell cat VERSION)))
# Package version release
VERSION_RELEASE = $(lastword $(subst -, ,$(shell cat VERSION)))

# Build directory
BUILD_DIR = $(shell pwd)/build

SOURCES_ORIG = $(PACKAGE)_$(VERSION).orig.tar.gz

$(BUILD_DIR): debian
	mkdir -p $@
	cp -R $< $@/$<

$(SOURCES_ORIG): $(BUILD_DIR)
	test -e $(PACKAGE)-$(VERSION).tar.gz || wget --no-check-certificate -O $(PACKAGE)-$(VERSION).tar.gz $(PACKAGE_SOURCE)$(VERSION).tar.gz
	cp $(PACKAGE)-$(VERSION).tar.gz $</$@

build:  clean $(BUILD_DIR) $(SOURCES_ORIG)
	cd $(BUILD_DIR) && debuild -us -uc -b

clean:
	@test ! -e $(BUILD_DIR) || rm -rf $(BUILD_DIR)
