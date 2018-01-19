require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.14.12'
  source_url 'https://www.cairographics.org/releases/cairo-1.14.12.tar.xz'
  source_sha256 '8c90f00c500b2299c0a323dd9beead2a00353752b2092ead558139bd67f7bf16'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fb449a39c94abb12d7997cb24bf57486b6e8a3baf7599484370adedffae0ecb0',
     armv7l: 'fb449a39c94abb12d7997cb24bf57486b6e8a3baf7599484370adedffae0ecb0',
       i686: 'bbd77b10c0d2a2a5e53046bf40659d896b84b9194d9e1065ed82f15dd584ee2a',
     x86_64: 'ced7600e3eadce92494d7be258c9bbb4f2d4975350129470f5eff882a4a205dd',
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
