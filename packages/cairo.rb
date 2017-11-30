require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.14.10-2'
  source_url 'https://www.cairographics.org/releases/cairo-1.14.10.tar.xz'
  source_sha256 '7e87878658f2c9951a14fc64114d4958c0e65ac47530b8ac3078b2ce41b66a09'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.10-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.10-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.10-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.10-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '633fcc8ce2775618ebbeebdbc008b3c236e54adae533b1267c33bcec6f92325f',
     armv7l: '633fcc8ce2775618ebbeebdbc008b3c236e54adae533b1267c33bcec6f92325f',
       i686: '60775d4ef3a59c87d03539c22ffa6749d4e902224151cef6d58191a0e68867c5',
     x86_64: '46628ed4142d73f627785a457223ffb59f1f7172aab2d1aecc95b2d982d4a429',
  })

  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'fontconfig' # pango requires cairo with fontconfig

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-xlib'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
