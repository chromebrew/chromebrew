require 'package'

class Lzo < Package
  description 'LZO is a portable lossless data compression library written in ANSI C.'
  homepage 'http://www.oberhumer.com/opensource/lzo/'
  version '2.10-1'
  compatibility 'all'
  source_url 'https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz'
  source_sha256 'c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8909723551598aea2da661c6e327d42ede4eedef60351113b2ee7923e45523d4',
     armv7l: '8909723551598aea2da661c6e327d42ede4eedef60351113b2ee7923e45523d4',
       i686: 'cec4de5d184f57d18660b4ea8a8ca5f69a8d80cc620e79dedc617f9fab04d63f',
     x86_64: '04c5e6c4405569793a8681869376ee5144258ced7c39eb06742f891fed741ff7',
  })

  def self.build
    system "./configure",
           '--enable-shared',
           '--disable-static',
           "--prefix=#{CREW_PREFIX}",
           '--disable-maintainer-mode',
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
