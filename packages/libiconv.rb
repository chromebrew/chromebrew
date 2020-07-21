require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.16'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.16.tar.gz'
  source_sha256 'e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'daee13f0eef96fb2d65a06d129f702cacbf8c70747d7f0dd2d27a9df977372b7',
     armv7l: 'daee13f0eef96fb2d65a06d129f702cacbf8c70747d7f0dd2d27a9df977372b7',
       i686: 'a7afa407d80bc94038711a636f10cf9af7fae7fce5b68220f4d9c51eca44849e',
     x86_64: 'cc29b28830c4bc496b2ef495e9dd43d96e596f879d02d7176222575bb83b5088',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-static --enable-relocatable --enable-extra-encodings"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
