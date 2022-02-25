require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  @_ver = '2.03.15'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.sourceware.org/pub/lvm2/releases/LVM2.#{@_ver}.tgz"
  source_sha256 '935283a51ee17abd752a545a0ed1cf4edc993359265bc9e562edf81500edc99e'

  depends_on 'libaio'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-selinux \
      --enable-cmdlib \
      --enable-dmeventd \
      --enable-pkgconfig \
      --with-symvers=no \
      --with-confdir=#{CREW_PREFIX}/etc"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
