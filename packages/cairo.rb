require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.14.10-1'
  source_url 'https://www.cairographics.org/releases/cairo-1.14.10.tar.xz'
  source_sha256 '7e87878658f2c9951a14fc64114d4958c0e65ac47530b8ac3078b2ce41b66a09'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.10-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.10-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.10-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.10-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '32e0aba6364a57b39d81fa58f0bad04a5ffca7ccd13f9f26c1a565447cafdc0a',
     armv7l: '32e0aba6364a57b39d81fa58f0bad04a5ffca7ccd13f9f26c1a565447cafdc0a',
       i686: '8b0e769f7402a4a0165c0a0f25348b20ec9daebc6a3e3cb85dbb8978b6e9aee4',
     x86_64: 'c0563bef3431022a8058baf99ec9f8a81f5e9246cad2466e37ca02c13900bd5e',
  })

  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'freetype'   # pango requires cairo with freetype
  depends_on 'fontconfig' # pango requires cairo with fontconfig

  def self.build
    system "./configure --disable-xlib"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
