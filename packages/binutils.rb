require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'http://www.gnu.org/software/binutils/'
  version '2.33.1'
  source_url 'https://ftpmirror.gnu.org/binutils/binutils-2.33.1.tar.lz'
  source_sha256 'a3239acf5c4efb7e8862a6684174c3b975766cf5f4be6fe25e424ab666ba1735'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.33.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.33.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.33.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.33.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aca082ab8458f1876e7ba3ac2560a396678809780f2b3582739fb0d3ed37c486',
     armv7l: 'aca082ab8458f1876e7ba3ac2560a396678809780f2b3582739fb0d3ed37c486',
       i686: '928f7b06a3f4ae28bb514c66a4805c468117489cb9318b81c8677b5ef3b36db6',
     x86_64: '495c10f7b7b325065d26fe374274a804666d5b433fc69cd1fc3d9dc85bb2742c',
  })

  depends_on 'filecmd'
  depends_on 'texinfo'

  def self.build
    system 'filefix'
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system '../configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--disable-maintainer-mode',
             '--enable-shared',
             '--enable-gold',
             '--enable-ld=default',
             '--enable-plugins',
             '--disable-bootstrap',
             '--enable-64-bit-bfd',
             '--disable-werror'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
