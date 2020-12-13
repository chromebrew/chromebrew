require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  version '2.35.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/binutils/binutils-2.35.1.tar.xz'
  source_sha256 '3ced91db9bf01182b7e420eab68039f2083aed0a214c0424e257eae3ddee8607'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.35.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.35.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.35.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.35.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c259bdd15e70638c5db025fb66f01272ee6125126efa66ad642ba1ca8c59ea1f',
     armv7l: 'c259bdd15e70638c5db025fb66f01272ee6125126efa66ad642ba1ca8c59ea1f',
       i686: '49e95626126656d02074397e60137bd652d01578582243ed313ce95182ea3f68',
     x86_64: '31511a8be2ead994bdf00cd61d6741eff3f8b2259177ff431dca28e57d2985dd',
  })

  depends_on 'filecmd'
  depends_on 'texinfo'

  def self.build
    system 'filefix'
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "../configure \
              #{CREW_OPTIONS} \
              --disable-maintainer-mode \
              --enable-shared \
              --enable-gold \
              --enable-ld=default \
              --enable-plugins \
              --disable-bootstrap \
              --enable-64-bit-bfd \
              --enable-lto \
              --enable-vtable-verify \
              --disable-werror"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
