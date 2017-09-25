CREW_PREFIX = /usr/local
CREW_LIB_PATH = $(CREW_PREFIX)/lib/crew

ALLTARGETS = $(sort $(basename $(notdir $(wildcard $(CREW_LIB_PATH)/packages/*))))
MINTARGETS = compressdoc libsigsegv patch diffutils ncursesw ncurses \
  readline pkgconfig make zlibpkg xzutils lzip m4 flex bison ed perl \
  libxml2 gettext texinfo bc openssl libssh2 gdbm sqlite curl expat \
  bz2 python27 git ruby less python3 libpipeline groff mandb fuse \
  libffi glib sshfs unzip
MIN2TARGETS = erlang filecmd go_bootstrap go gawk lz4 acl attr libarchive \
  cmake autoconf autoconf_archive automake libtool emacs vim neovim \
  nano libpng libxslt pcre php5 php7 screen readline7 tcl expect
MIN3TARGETS = pixman cairo a2png gperf a2ps icu4c harfbuzz freetype \
  fontconfig pango optipng netcat ncftp ncdu patchelf openssh patchutils \
  protobuf cpio ctags scons libpcap tcpdump tcpstat lha unrar zsh \
  libjpeg libtiff imagemagick imagemagick6

TOOLCHAINS = binutils cloog gcc glibc219 glibc223 gmp isl linuxheaders mpc mpfr
FAKES = glibc buildessential parallel wayland xorg_proto
LICENSEPROHIBIT = jdk8
# PRECOMPILED = elixir sejda_console platformsh
# SCRIPTS = gifgen yarn nodebrew
# MODIFYENV = nvm
CRASH = get_iplayer
BINTARGETS =  lldb $(TOOLCHAINS) $(FAKES) $(LICENSEPROHIBIT) $(PRECOMPILED) $(SCRIPTS) $(MODIFYENV) $(CRASH)

#scripts
GENPKGNAME = ./genpkgname.sh
BUILD = ./build.sh

all: $(ALLTARGETS)
min: $(MINTARGETS)
min2: $(MIN2TARGETS)
min3: $(MIN3TARGETS)

define make-target
  $1: $(shell $(GENPKGNAME) $1)
  $(shell $(GENPKGNAME) $1):
	$(BUILD) $1
#  all-targets:: $(shell $(GENPKGNAME) $1)
endef

define make-dummy-target
  $1: $(shell $(GENPKGNAME) $1)
  $(shell $(GENPKGNAME) $1): $(CREW_LIB_PATH)/packages/$1.rb
#	@echo nothing to do for binary or fake package $1
endef

$(foreach pkg, $(filter-out $(BINTARGETS),$(ALLTARGETS)), $(eval $(call make-target,$(pkg))))

$(foreach pkg, $(BINTARGETS), $(eval $(call make-dummy-target,$(pkg))))
