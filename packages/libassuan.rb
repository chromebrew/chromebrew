require 'package'

class Libassuan < Package
  description 'Libassuan is a small library implementing the so-called Assuan protocol.'
  homepage 'https://www.gnupg.org/related_software/libassuan/index.html'
  version '2.5.5'
  license 'GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-#{version}.tar.bz2"
  source_sha256 '8e8c2fcc982f9ca67dcbb1d95e2dc746b1739a4668bc20b3a3c5be632edb34e4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libassuan-2.5.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libassuan-2.5.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libassuan-2.5.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libassuan-2.5.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b4be3da9f16aface28732f3edd20af5bc888cef9897a950484dc073d87793963',
     armv7l: 'b4be3da9f16aface28732f3edd20af5bc888cef9897a950484dc073d87793963',
       i686: '0ef14cd312f4dc8208fb6942571e5352c7867a067b006df56bac18c0fea75193',
     x86_64: '87943e7a7b0433246e913380b5e5c895385e5cf8325ed47a33d637050a72a76c'
  })

  depends_on 'libgpgerror'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
