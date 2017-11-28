require 'package'

class Lzo < Package
  description 'LZO is a portable lossless data compression library written in ANSI C.'
  homepage 'http://www.oberhumer.com/opensource/lzo/'
  version '2.10'
  source_url 'http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz'
  source_sha256 'c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-dependency-tracking \
            --disable-maintainer-mode"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
