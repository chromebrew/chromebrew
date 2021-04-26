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
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libgpgerror-1.42-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libgpgerror-1.42-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/libgpgerror-1.42-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/libgpgerror-1.42-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9864ed50574b3830c7e613392e6bdccf1be8857d5e40263b8d31f535481db547',
     armv7l: '9864ed50574b3830c7e613392e6bdccf1be8857d5e40263b8d31f535481db547',
       i686: 'fe6ff6e681c9d7730ef69f696d759528b67fa5a5e2f5be584c1277b0ee0498a0',
     x86_64: '041069951d95c281c22e1f50e06d8402d35c6682d16483da1881e4c20691e6b9'
  })

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
