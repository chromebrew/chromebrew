require 'package'

class Log4c < Package
  description 'Log4c is a library of C for flexible logging to files, syslog and other destinations.'
  homepage 'http://log4c.sourceforge.net/'
  version '1.2.4'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/log4c/log4c/1.2.4/log4c-1.2.4.tar.gz'
  source_sha256 '5991020192f52cc40fa852fbf6bbf5bd5db5d5d00aa9905c67f6f0eadeed48ea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/log4c-1.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/log4c-1.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/log4c-1.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/log4c-1.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '289c51fe0be603f1fe6a5c95482ba7eb4ae234c4f79164429cb86b07a6d5b877',
     armv7l: '289c51fe0be603f1fe6a5c95482ba7eb4ae234c4f79164429cb86b07a6d5b877',
       i686: '76f96639ac66b51b82e7050ade976f3d252974a0ed29504a9e49b7bb7af4fb13',
     x86_64: 'bde0cc2a13a7435e56aa98f283d56f6f14d100ab3f6490bf0202e011b657b3ce',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
