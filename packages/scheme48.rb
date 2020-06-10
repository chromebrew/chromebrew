require 'package'

class Scheme48 < Package
  description 'Scheme byte-code interpreter'
  homepage 'http://s48.org/'
  version '1.9.2'
  compatibility 'all'
  source_url 'http://s48.org/1.9.2/scheme48-1.9.2.tgz'
  source_sha256 '9c4921a90e95daee067cd2e9cc0ffe09e118f4da01c0c0198e577c4f47759df4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/scheme48-1.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/scheme48-1.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/scheme48-1.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/scheme48-1.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ea7ebd83c9fd176cadeb3ba22e70d030942a199660a1c47d1e6c10d4c441febd',
     armv7l: 'ea7ebd83c9fd176cadeb3ba22e70d030942a199660a1c47d1e6c10d4c441febd',
       i686: 'c2ccae4624713af8a7708940d6f6f364b25ee39cf5d7f0259ce0960bdf11d554',
     x86_64: '576f041ade2a539f3ed8a9c9dd5e20f0bf831620f8e8847fec7064b81804807c',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
