require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org'
  version '2.30-0'
  source_url 'https://www.kernel.org/pub/linux/utils/util-linux/v2.30/util-linux-2.30.tar.xz'
  source_sha256 'c208a4ff6906cb7f57940aa5bc3a6eed146e50a7cc0a092f52ef2ab65057a08d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.30-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.30-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.30-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.30-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dfa70b1c93cf5d2ed803bfe9791169a4c28ae5be1a0031b869ef08feb6269058',
     armv7l: 'dfa70b1c93cf5d2ed803bfe9791169a4c28ae5be1a0031b869ef08feb6269058',
       i686: '0dd78693e31a8a76506eeda1dc2d9979e168360271172c64ae6059623ed5533f',
     x86_64: '1ac3be75194c2bde5daaf034a9e33f1beb23f1c45ad60ece039401682ff5e909',
  })

  depends_on 'python27'
  depends_on 'libcap_ng'
  depends_on 'vdev'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "sed -i '/chgrp/d' ./Makefile"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
