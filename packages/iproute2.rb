# Adapted from Arch Linux iproute2 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/iproute2/trunk/PKGBUILD

require 'package'

class Iproute2 < Package
  description 'IP Routing Utilities'
  homepage 'https://git.kernel.org/pub/scm/network/iproute2/iproute2.git'
  version '6.16.0'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-#{version}.tar.xz"
  source_sha256 '5900ccc15f9ac3bf7b7eae81deb5937123df35e99347a7f11a22818482f0a8d0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec11b879ffb84aab7cbf8df0c35a153257544cb0528d5d5c53907264ef113572',
     armv7l: 'ec11b879ffb84aab7cbf8df0c35a153257544cb0528d5d5c53907264ef113572',
     x86_64: 'b3560f0dd6122b7d51a8f97c3044b23467f8813c024d9bbd6dfb1a5d3732e872'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'iptables' # R
  depends_on 'libbpf' unless ARCH == 'i686'
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
