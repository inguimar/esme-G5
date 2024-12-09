# for compiling with a specific toolchain:
# set following variables:
#
# CC: C compiler executable (ex: arm-linux-gnueabihf-gcc, gcc)
# LD: linker executable (ex: arm-linux-gnueabihf-ld, ld)
# CPP: C preprocessor (ex:  arm-linux-gnueabihf-cpp, cpp)
# CXX: C++ compiler (ex: arm-linux-gnueabihf-g++, g++)
# CFLAGS: flags to pass to the C compiler
# LDFLAGS: flags to pass to the linker
# LDLIBS: list of libs to link against during link phase (ex: -lc -lz)

PROGRAM := esme-3S5-gpio-toggle
OBJECTS := esme-3S5-gpio-toggle.o

CFLAGS += $(shell pkg-config --cflags libgpiod )
LDLIBS += $(shell pkg-config --libs libgpiod )

INSTALL_DIR ?= ./.install
INSTALL := $(INSTALL_DIR)/usr/bin
INSTALL := $(INSTALL_DIR)/etc/init.d

# default target (all)
all: $(PROGRAM)

$(PROGRAM): $(OBJECTS)

install: $(PROGRAM)
	@echo "Installation du programme dans $(INSTALL)..."
	@mkdir -p $(INSTALL)
	@cp $(PROGRAM) $(INSTALL)
	@echo "Programme installé avec succès dans $(INSTALL)"

@echo "Installation du script dans $(INSTALL)..."
	@mkdir -p $(INSTALL)
	@cp esme-gpio26-toggle $(INSTALL)
	@chmod 0755 $(INSTALL)/esme-gpio26-toggle
	@echo "Script esme-gpio26-toggle installé avec succès dans $(INSTALL) avec les bonnes permissions."


clean:
	-$(RM) -f  $(PROGRAM)
	-$(RM) -f  $(OBJECTS)

uninstall:
	@echo "Suppression des fichiers installés..."
	@$(RM) -f $(INSTALL)/$(PROGRAM)
	@$(RM) -f $(INSTALL)/esme-gpio26-toggle
	@rmdir --ignore-fail-on-non-empty $(INSTALL) $(INSTALL_DIR)/usr
	@echo "Fichiers d'installation supprimés."

.PHONY: all clean install uninstall

