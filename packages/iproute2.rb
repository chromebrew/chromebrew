# Adapted from Arch Linux iproute2 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/iproute2/trunk/PKGBUILD

require 'package'

class Iproute2 < Package
  description 'IP Routing Utilities'
  homepage 'https://git.kernel.org/pub/scm/network/iproute2/iproute2.git'
  version '7.1.0'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-#{version}.tar.xz"
  source_sha256 'fd9fa1b95809417157ca83dd72957e3261bdbce896353cb936f80af0b33a4b5c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '553fa2fd9e95b9e38610c0ad0f7fdc34ee574788f7057debf8b90bb80e17f525',
     armv7l: '553fa2fd9e95b9e38610c0ad0f7fdc34ee574788f7057debf8b90bb80e17f525',
     x86_64: 'a53a0be9261b0303d2c16053340cad4cf1e106b8f4f430ea560040ea056b23d1'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'iptables' => :executable
  depends_on 'libbpf' => :executable
  depends_on 'libbpf' unless ARCH == 'i686'
  depends_on 'libbsd' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libdb' => :executable
  depends_on 'libtirpc' => :executable

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
