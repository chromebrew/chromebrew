require 'package'

class Libassuan < Package
  description 'Libassuan is a small library implementing the so-called Assuan protocol.'
  homepage 'https://www.gnupg.org/related_software/libassuan/index.html'
  version '2.5.5'
  license 'GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-#{version}.tar.bz2"
  source_sha256 '8e8c2fcc982f9ca67dcbb1d95e2dc746b1739a4668bc20b3a3c5be632edb34e4'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '853b20547fd035aa2b8e8e3653cfbbd1adc70f6b1f453a41776fa4799519a4d5',
     armv7l: '853b20547fd035aa2b8e8e3653cfbbd1adc70f6b1f453a41776fa4799519a4d5',
       i686: '6cb8279e8d9df539022f5b64cfdf42cccea3aea6f482b2fcd7a875c3a4ffac09',
     x86_64: '9db3d46f74bf1446748f29165a163ee2c87bfcc6b7074b060fb8221146be85ec'
  })

  depends_on 'libgpgerror'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
