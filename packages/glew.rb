require 'package'

class Glew < Package
  description 'GLEW provides efficient run-time mechanisms for determining which OpenGL extensions are supported on the target platform'
  homepage 'http://glew.sourceforge.net/'
  version '2.1.0-1'
  compatibility 'all'
  source_url 'https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.tgz'
  source_sha256 '04de91e7e6763039bc11940095cd9c7f880baba82196a7765f727ac05a993c95'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.1.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.1.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.1.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glew-2.1.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd80923b6a32ec1b38df81dcd7860516d140c57157e3dea23a37d8f874c1cbbe3',
     armv7l: 'd80923b6a32ec1b38df81dcd7860516d140c57157e3dea23a37d8f874c1cbbe3',
       i686: '9dbd934bdf44c5109f9e52931801c2c0fb0b7806f146d4ead90a129bb31ebac1',
     x86_64: '0496b31639402805881fa3312aaf8bea3b4239734b38935bbc53a10d48bcc840',
  })

  depends_on 'mesa'

  def self.build
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}",
             './cmake'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
