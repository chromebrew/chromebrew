require 'package'

class Haveged < Package
  description 'A simple entropy daemon based on the HAVEGE algorithm, significantly faster than /dev/urandom.'
  homepage 'https://issihosts.com/haveged/'
  version '1.9.14'
  compatibility 'all'
  source_url 'https://github.com/jirka-h/haveged/archive/v1.9.14.tar.gz'
  source_sha256 '938cb494bcad7e4f24e61eb50fab4aa0acbc3240c80f3ad5c6cf7e6e922618c3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/haveged-1.9.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/haveged-1.9.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/haveged-1.9.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/haveged-1.9.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9089376d8df95644f812c8f9226e729e12fb68c4ebe4c365a52862f0d7ba1fc9',
     armv7l: '9089376d8df95644f812c8f9226e729e12fb68c4ebe4c365a52862f0d7ba1fc9',
       i686: 'c3f4e3381887a68cc8a0b1194d8b16012d268dde46b32b74c1009a1b89fcd2dd',
     x86_64: 'ed0492d5350f653b8ea93ef67ea1da5d611d3988879aa59c8c735810789da0f5',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --disable-daemon \
            --enable-nistest \
            --enable-enttest \
            --enable-olt \
            --enable-threads"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
