require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  version '2.35.1-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/binutils/binutils-2.35.1.tar.xz'
  source_sha256 '3ced91db9bf01182b7e420eab68039f2083aed0a214c0424e257eae3ddee8607'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.35.1-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.35.1-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.35.1-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.35.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'ccadf54533ef07715dfe17e4dec9639a0c6e1c34e1df780f936ede7d7233db27',
      armv7l: 'ccadf54533ef07715dfe17e4dec9639a0c6e1c34e1df780f936ede7d7233db27',
        i686: '5fda35d6de84ae32d29d7369a36b4e8220a1304ed978d76b9fdcc5bc17961565',
      x86_64: '20fd8355151fd24dab6a82123a1d04c7a9dcb94cb2841df2795c6bc21a1107df',
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
              --enable-install-libiberty"
      system 'make'
    end
  end

  def self.check
    Dir.chdir 'build' do
      system 'make check || true'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
