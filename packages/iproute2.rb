# Adapted from Arch Linux iproute2 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/iproute2/trunk/PKGBUILD

require 'package'

class Iproute2 < Package
  description 'IP Routing Utilities'
  homepage 'https://git.kernel.org/pub/scm/network/iproute2/iproute2.git'
  version '6.1.0'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.1.0.tar.xz'
  source_sha256 '5ce12a0fec6b212725ef218735941b2dab76244db7e72646a76021b0537b43ab'
  binary_compression 'tar.zst'

  binary_sha256({
     aarch64: '5f7277867d9fb2192273a7defb083dbe4dfb2dc7e0afc65049418a8c5c0bebef',
      armv7l: '5f7277867d9fb2192273a7defb083dbe4dfb2dc7e0afc65049418a8c5c0bebef',
      x86_64: '72308fddc001ba8a049f347337d5c26c02853695daae8042319381f272c00a3a'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'iptables' # R
  depends_on 'libbpf' unless ARCH == 'i686'
  depends_on 'libcap' # R
  depends_on 'libtirpc' # R

  def self.patch
    system "sed -i 's/-Werror//' Makefile"
    system "sed -i 's,^PREFIX?=/usr,PREFIX?=#{CREW_PREFIX},g' Makefile"
    system "sed -i 's,KERNEL_INCLUDE?=/usr/include,KERNEL_INCLUDE?=$(PREFIX)/include,g' Makefile"
    system "sed -i 's,DBM_INCLUDE:=$(DESTDIR)/usr/include,DBM_INCLUDE:=$(PREFIX)/include,g' Makefile"
    system "sed -i 's,/etc,$(PREFIX)/etc,g' Makefile"
    system "sed -i 's,/var,$(PREFIX)/var,g' Makefile"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --include_dir=#{CREW_PREFIX}/include"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/include
      #{CREW_DEST_LIB_PREFIX}
    ]
    system "make DESTDIR=#{CREW_DEST_DIR} SBINDIR=#{CREW_PREFIX}/bin install"
    FileUtils.install 'include/libnetlink.h', "#{CREW_DEST_PREFIX}/include/libnetlink.h", mode: 0o644
    FileUtils.install 'lib/libnetlink.a', "#{CREW_DEST_LIB_PREFIX}/libnetlink.a", mode: 0o644
  end
end
