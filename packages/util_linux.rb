require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org'
  version '2.30'
  source_url 'https://www.kernel.org/pub/linux/utils/util-linux/v2.30/util-linux-2.30.tar.xz'
  source_sha256 'c208a4ff6906cb7f57940aa5bc3a6eed146e50a7cc0a092f52ef2ab65057a08d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.30-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.30-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.30-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.30-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ff514e1b234fea8d7df4dc27d3c17e1741a4289353d2335dc3e28eb948ee404',
     armv7l: '5ff514e1b234fea8d7df4dc27d3c17e1741a4289353d2335dc3e28eb948ee404',
       i686: 'f974237691ae726c55045b2b1e556af0efcbf943e34961c4801601c6ccf8ed6e',
     x86_64: 'eab34f391bc111d3f6985de8619e6b5c41e1bd0652256e80cb57f4422bdfb72a',
  })

  depends_on 'python27'
  depends_on 'libcap_ng'
  depends_on 'vdev'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "sed -i '/chgrp/d' ./Makefile"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
