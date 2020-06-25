require 'package'

class Libglu < Package
  description 'Mesa OpenGL Utility library'
  homepage 'https://www.mesa3d.org/'
  version '9.0.1'
  compatibility 'all'
  source_url 'https://archive.mesa3d.org/glu/glu-9.0.1.tar.xz'
  source_sha256 'fb5a4c2dd6ba6d1c21ab7c05129b0769544e1d68e1e3b0ffecb18e73c93055bc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libglu-9.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libglu-9.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libglu-9.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libglu-9.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0bf229621676810287e72253faf88af8d6fc7e2c295a6110c30e50b4c841dd36',
     armv7l: '0bf229621676810287e72253faf88af8d6fc7e2c295a6110c30e50b4c841dd36',
       i686: 'f37f39c65fcf0e22e741da79e7cd3a7e21e61ddd84f871996b81a1df6b376d53',
     x86_64: 'ce186ee083b0c2b6061b72fa1d8af22ada95d3b9c3ae1bfbc48bc2977b65e176',
  })

  depends_on 'mesa'
  depends_on 'xorg_lib'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
