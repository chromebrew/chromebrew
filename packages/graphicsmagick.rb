require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.28'
  source_url 'http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.28/GraphicsMagick-1.3.28.tar.xz'
  source_sha256 '942a68a9a8a5af6f682b896fd4f0ad617d8b49907e474acfe59549956bcc994a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b34b0b5c2a85a0e1e410b5ea43ad22459aa102ca65d1fb70fe56442d93969936',
     armv7l: 'b34b0b5c2a85a0e1e410b5ea43ad22459aa102ca65d1fb70fe56442d93969936',
       i686: 'bd8d55e6347d2bb1fb27a87883c6dc8aecacbf905c41c92a2c28bd75528f1242',
     x86_64: 'c92c2a2630342f13ef3e6e89cb07fc1b90d0b281cef401047271dd243ab8618e',
  })

  depends_on 'freetype'
  depends_on 'lcms'
  depends_on 'libwebp'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--enable-magick-compat',
           '--with-modules',
           '--with-xml'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
