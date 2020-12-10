require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  version '2.35.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/binutils/binutils-2.35.1.tar.xz'
  source_sha256 '3ced91db9bf01182b7e420eab68039f2083aed0a214c0424e257eae3ddee8607'


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
