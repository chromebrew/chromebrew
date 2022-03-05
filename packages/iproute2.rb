# Adapted from Arch Linux iproute2 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/iproute2/trunk/PKGBUILD

require 'package'

class Iproute2 < Package
  description 'IP Routing Utilities'
  homepage 'https://git.kernel.org/pub/scm/network/iproute2/iproute2.git'
  version '5.16.0'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.16.0.tar.xz'
  source_sha256 'c064b66f6b001c2a35aa5224b5b1ac8aa4bee104d7dce30d6f10a84cb8b01e2f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iproute2/5.16.0_armv7l/iproute2-5.16.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iproute2/5.16.0_armv7l/iproute2-5.16.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iproute2/5.16.0_i686/iproute2-5.16.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iproute2/5.16.0_x86_64/iproute2-5.16.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ce61bbe2bd40484edcafd1acad7a1a57a0a4666ff283055141093c48d2bfa709',
     armv7l: 'ce61bbe2bd40484edcafd1acad7a1a57a0a4666ff283055141093c48d2bfa709',
       i686: '42422341af0c46a6fea69cd03a46f31d9ed58c1755de34b516123d5b231f9b1f',
     x86_64: '849fcfd35a20595c20683b143d4bc49a13322b638ab92fec37dfbfdd7e480ea2'
  })

  depends_on 'iptables'
  depends_on 'elfutils'

  def self.patch
    @iproute2_fhs_patch = <<~'IPROUTE2_FHS_EOF'
      From f0624f6cc656cb177b64e2664f2a806221bfab58 Mon Sep 17 00:00:00 2001
      From: Christian Hesse <mail@eworm.de>
      Date: Thu, 28 Jul 2016 08:49:20 +0200
      Subject: [PATCH 1/1] make iproute2 fhs compliant

      Signed-off-by: Christian Hesse <mail@eworm.de>
      ---
       Makefile       |  2 +-
       netem/Makefile |  4 ++--
       tc/q_netem.c   |  2 +-
       tc/tc_util.c   | 15 +++++++++++++++
       tc/tc_util.h   |  1 +
       5 files changed, 20 insertions(+), 4 deletions(-)

      diff --git a/Makefile b/Makefile
      index eb571a5..db0a04c 100644
      --- a/Makefile
      +++ b/Makefile
      @@ -14,7 +14,7 @@ DBM_INCLUDE:=$(DESTDIR)/usr/include
       
       SHARED_LIBS = y
       
      -DEFINES= -DRESOLVE_HOSTNAMES -DLIBDIR=\"$(LIBDIR)\"
      +DEFINES= -DRESOLVE_HOSTNAMES -DLIBDIR=\"$(LIBDIR)\" -DDATADIR=\"$(DATADIR)\"
       ifneq ($(SHARED_LIBS),y)
       DEFINES+= -DNO_SHARED_LIBS
       endif
      diff --git a/netem/Makefile b/netem/Makefile
      index e52e125..5b4d283 100644
      --- a/netem/Makefile
      +++ b/netem/Makefile
      @@ -20,9 +20,9 @@ stats: stats.c
       	$(HOSTCC) $(CCOPTS) -I../include -o $@ $@.c -lm
       
       install: all
      -	mkdir -p $(DESTDIR)$(LIBDIR)/tc
      +	mkdir -p $(DESTDIR)$(DATADIR)/tc
       	for i in $(DISTDATA); \
      -	do install -m 644 $$i $(DESTDIR)$(LIBDIR)/tc; \
      +	do install -m 644 $$i $(DESTDIR)$(DATADIR)/tc; \
       	done
       
       clean:
      diff --git a/tc/q_netem.c b/tc/q_netem.c
      index 8fe2204..a15a5c7 100644
      --- a/tc/q_netem.c
      +++ b/tc/q_netem.c
      @@ -113,7 +113,7 @@ static int get_distribution(const char *type, __s16 *data, int maxdata)
       	char *line = NULL;
       	char name[128];
       
      -	snprintf(name, sizeof(name), "%s/%s.dist", get_tc_lib(), type);
      +	snprintf(name, sizeof(name), "%s/%s.dist", get_tc_datadir(), type);
       	if ((f = fopen(name, "r")) == NULL) {
       		fprintf(stderr, "No distribution data for %s (%s: %s)\n",
       			type, name, strerror(errno));
      diff --git a/tc/tc_util.c b/tc/tc_util.c
      index afc4cf5..728b854 100644
      --- a/tc/tc_util.c
      +++ b/tc/tc_util.c
      @@ -32,6 +32,10 @@
       #define LIBDIR "/usr/lib"
       #endif
       
      +#ifndef DATADIR
      +#define DATADIR "/usr/share"
      +#endif
      +
       static struct db_names *cls_names;
       
       #define NAMES_DB "/etc/iproute2/tc_cls"
      @@ -73,6 +77,17 @@ const char *get_tc_lib(void)
       	return lib_dir;
       }
       
      +const char *get_tc_datadir(void)
      +{
      +	const char *data_dir;
      +
      +	data_dir = getenv("TC_DATA_DIR");
      +	if (!data_dir)
      +		data_dir = DATADIR "/tc/";
      +
      +	return data_dir;
      +}
      +
       int get_qdisc_handle(__u32 *h, const char *str)
       {
       	__u32 maj;
      diff --git a/tc/tc_util.h b/tc/tc_util.h
      index 61e60b1..6d448de 100644
      --- a/tc/tc_util.h
      +++ b/tc/tc_util.h
      @@ -55,6 +55,7 @@ struct exec_util {
       };
       
       const char *get_tc_lib(void);
      +const char *get_tc_datadir(void);
       
       struct qdisc_util *get_qdisc_kind(const char *str);
       struct filter_util *get_filter_kind(const char *str);
    IPROUTE2_FHS_EOF
    File.write('0001-make-iproute2-fhs-compliant.patch', @iproute2_fhs_patch)
    system 'patch -Np1 -i 0001-make-iproute2-fhs-compliant.patch'
    system "sed -i 's/-Werror//' Makefile"
  end

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} SBINDIR=#{CREW_PREFIX}/bin install"
    system "install -Dm0644 include/libnetlink.h #{CREW_DEST_PREFIX}/include/libnetlink.h"
    system "install -Dm0644 lib/libnetlink.a #{CREW_DEST_LIB_PREFIX}/libnetlink.a"
  end
end
