require 'package'

class Lzo < Package
  description 'LZO is a portable lossless data compression library written in ANSI C.'
  homepage 'http://www.oberhumer.com/opensource/lzo/'
  version '2.10-1'
  source_url 'https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz'
  source_sha256 'c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '6427640990d44d3e8d9c16856a40de6442624e821e64dc8441373bbcd34f71f1',
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
