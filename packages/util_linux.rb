require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.36.1-2'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.36/util-linux-2.36.1.tar.xz'
  source_sha256 '09fac242172cd8ec27f0739d8d192402c69417617091d8c6e974841568f37eed'

  depends_on 'libcap_ng'
  depends_on 'eudev'
  depends_on 'libtinfo'
  depends_on 'linux_pam'
  depends_on 'pcre2'
  depends_on 'libeconf'

  def self.build
    system "./configure #{CREW_OPTIONS} \
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
