require 'package'

class Imlib2 < Package
  description 'library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support, etc.'
  homepage 'https://sourceforge.net/projects/enlightenment/'
  version '1.5.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/enlightenment/imlib2-1.5.1.tar.bz2'
  source_sha256 'fa4e57452b8843f4a70f70fd435c746ae2ace813250f8c65f977db5d7914baae'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imlib2-1.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imlib2-1.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imlib2-1.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imlib2-1.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6f0ba9fab8919ca237a7e6cf685b2bda016392f10b8f65dbb8c290dd376de9a2',
     armv7l: '6f0ba9fab8919ca237a7e6cf685b2bda016392f10b8f65dbb8c290dd376de9a2',
       i686: 'aadf78515aa8456ea66f8fe294ad15031dcbe4f2696c6ed56f7810ff0b5c3976',
     x86_64: '03cb7e8861fadc3724814bce639898416e09eb73a5fd5ac6e1ab76769434a171',
  })

  depends_on 'freetype'
  depends_on 'giflib'
  depends_on 'libid3tag'
  depends_on 'libjpeg_turbo'
  depends_on 'libtiff'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
