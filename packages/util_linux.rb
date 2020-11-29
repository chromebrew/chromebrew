require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.36.1'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.36/util-linux-2.36.1.tar.xz'
  source_sha256 '09fac242172cd8ec27f0739d8d192402c69417617091d8c6e974841568f37eed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0909ce58f367e6668f524c36f1427914a58b9b1b6d5364e9bd8dcf17bfdb006',
     armv7l: 'f0909ce58f367e6668f524c36f1427914a58b9b1b6d5364e9bd8dcf17bfdb006',
       i686: 'dc83478004607b079cbe6590cbbc8417a67fcebeb9cb25450b8ebe0b6c5ad757',
     x86_64: '9881068983c0b84e08b9bd9a450807f0bfcd823c0dee49721773bdbfcfdb6c8f',
  })

  depends_on 'libcap_ng'
  depends_on 'vdev'
  depends_on 'libtinfo'
  depends_on 'linux_pam'
  depends_on 'pcre2'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-python=3 \
    --enable-fs-paths-extra=#{CREW_PREFIX}/sbin"
    system "sed -i -e '/chgrp/d' -e '/chown/d' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
