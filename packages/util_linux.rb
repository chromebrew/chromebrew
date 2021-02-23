require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.36.2'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.36/util-linux-2.36.2.tar.xz'
  source_sha256 'f7516ba9d8689343594356f0e5e1a5f0da34adfbc89023437735872bb5024c5f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '55c8e9851dfd613a7e6649d125e34f0909a3f11d7c2d2c27e5e621220deb7a7b',
     armv7l: '55c8e9851dfd613a7e6649d125e34f0909a3f11d7c2d2c27e5e621220deb7a7b',
       i686: '6b5b92a021890bbf4d56e20ba7385bd1e94d19a531df8b443b7d4d7f828f54f8',
     x86_64: '53cd71202fd331562a181ccd67a464378174d2c0e6503a0d738eec24a03d69a1'
  })

  depends_on 'libcap_ng'
  depends_on 'eudev'
  depends_on 'libtinfo'
  depends_on 'linux_pam'
  depends_on 'libeconf'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-python=3 \
      --enable-fs-paths-extra=#{CREW_PREFIX}/sbin \
      --without-systemd \
      --with-econf \
      --with-ncursesw \
      --without-cryptsetup"
    system "sed -i -e '/chgrp/d' -e '/chown/d' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
