# Adapted from Arch Linux iproute2 PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/iproute2/trunk/PKGBUILD

require 'package'

class Iproute2 < Package
  description 'IP Routing Utilities'
  homepage 'https://git.kernel.org/pub/scm/network/iproute2/iproute2.git'
  version '7.0.0'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-#{version}.tar.xz"
  source_sha256 'e62890f7b5de63c05a3bf331dc8deb4c015c336013f341a4edf46969797f2f4e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae57b3e5b95611297c91b277441b424662cbf12b07c90d319f0809a3e5de25f4',
     armv7l: 'ae57b3e5b95611297c91b277441b424662cbf12b07c90d319f0809a3e5de25f4',
     x86_64: 'f20c6ef4e3353dc90e8deead244594ae4af2e5667761d4c863e8e2411eb2e8be'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
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
