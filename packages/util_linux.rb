require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.36.1-1'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.36/util-linux-2.36.1.tar.xz'
  source_sha256 '09fac242172cd8ec27f0739d8d192402c69417617091d8c6e974841568f37eed'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.1-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.1-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.1-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.36.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'e9ce7f671712be809d2d6dd1f0c254f64c9813eefbdb58920a141a7c42d0bd2b',
      armv7l: 'e9ce7f671712be809d2d6dd1f0c254f64c9813eefbdb58920a141a7c42d0bd2b',
        i686: '0fc3331a278e0b2463bb8832b68a7a7f5aadabe73fab127734394d3618169685',
      x86_64: '3b247f8d48861c5012e6eda8e1545d16ea798212a7f2f579e439ddf2115cf121',
  })

  depends_on 'libcap_ng'
  depends_on 'eudev'
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
