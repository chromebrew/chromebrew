require 'package'

class Scrollz < Package
  description 'ScrollZ is an advanced IRC client based on ircII.'
  homepage 'http://www.scrollz.info/'
  version '2.3-1'
  source_url 'http://www.scrollz.info/download/ScrollZ-2.3.tar.gz'
  source_sha256 '22535bcc54ad752107ab181775d90d9cf1b37648f500d627f428388a9d3710e6'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/scrollz-2.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/scrollz-2.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/scrollz-2.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/scrollz-2.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a1589b1e4fd8ff13d2ab43196a169d8059763a6f2a5211197fc1531b8c9e5a31',
     armv7l: 'a1589b1e4fd8ff13d2ab43196a169d8059763a6f2a5211197fc1531b8c9e5a31',
       i686: 'c627771e1fefb36d8f5b07b603c7ee5ffeb740148275926c03ae6948172cfe7d',
     x86_64: 'b5ec0e2e979a79e9b292d221b4875ce79364f881504bc1ecbce503993b728f73',
  })

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    system "CFLAGS=-I/usr/local/include/ncurses ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
