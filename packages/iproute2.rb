# Adapted from Arch Linux iproute2 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/iproute2/trunk/PKGBUILD

require 'package'

class Iproute2 < Package
  description 'IP Routing Utilities'
  homepage 'https://git.kernel.org/pub/scm/network/iproute2/iproute2.git'
  version '6.18.0'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-#{version}.tar.xz"
  source_sha256 '6ba520e1975e4c50dc931eeae91ea37c198b8a173744885f8895b84325f9d456'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c31cfe2b335386ff6e9c431eec458d635c0e534eae5a6e1022c0fc5bfac0c58',
     armv7l: '6c31cfe2b335386ff6e9c431eec458d635c0e534eae5a6e1022c0fc5bfac0c58',
     x86_64: 'b847e2299f9f5b41005bdbc9e6a235eda8c1fb3d50d829ef453ddc951412cf12'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'iptables' # R
  depends_on 'libbpf' unless ARCH == 'i686'
  depends_on 'libbsd' # R
  depends_on 'libcap' # R
  depends_on 'libdb' # R
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
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
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
