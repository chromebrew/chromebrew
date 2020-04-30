require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  version '2.34'
  source_url 'https://ftpmirror.gnu.org/binutils/binutils-2.34.tar.lz'
  source_sha256 '5cec79823ef596817aa57a3f470a1afa9827bf14e3583a4e445dc046cc38d29c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.34-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.34-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.34-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binutils-2.34-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b8194c2d9448796a2c8c5a2e0be669ab32b2a2fb832b4acccff09cb417d0d91f',
     armv7l: 'b8194c2d9448796a2c8c5a2e0be669ab32b2a2fb832b4acccff09cb417d0d91f',
       i686: '30a101614d39a99caebd12b3037917a428c618fd4378a04c21469d201c2e9fff',
     x86_64: 'cc790a554f99715bd5cccefd14f965d885ef2c694afd461007a7f3b37386b91b',
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
