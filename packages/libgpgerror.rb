require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.42'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  source_sha256 'fc07e70f6c615f8c4f590a8e37a9b8dd2e2ca1e9408f8e60459c67452b925e23'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.42-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.42-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.42-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.42-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8cffadf3c6dcdb64739bf74fe14e5d369dea42697f63be5e22c95db51b0b0570',
     armv7l: '8cffadf3c6dcdb64739bf74fe14e5d369dea42697f63be5e22c95db51b0b0570',
       i686: 'b60cfadd29f2e42bcec05e4f47a52fdcaa519011aa079914c96622c2bdd8013d',
     x86_64: '495665be0c2a6628d7202a91d7c74b28ca1dfb81603d16a529936e1b19af2ed6'
  })

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
