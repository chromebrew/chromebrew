require 'package'

class Xbitmaps < Package
  description 'The xbitmaps package contains bitmap images used by multiple applications built in Xorg chapter.'
  homepage 'http://www.x.org'
  version '1.1.1'
  source_url 'https://www.x.org/pub/individual/data/xbitmaps-1.1.1.tar.bz2'
  source_sha256 '3671b034356bbc4d32d052808cf646c940ec8b2d1913adac51b1453e41aa1e9d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "util_macros" => :build


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
