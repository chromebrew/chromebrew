require 'package'

class Libglu < Package
  description 'Mesa OpenGL Utility library'
  homepage 'https://www.mesa3d.org/'
  version '9.0.0'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/glu/glu-9.0.0.tar.bz2'
  source_sha256 '1f7ad0d379a722fcbd303aa5650c6d7d5544fde83196b42a73d1193568a4df12'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libglu-9.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libglu-9.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libglu-9.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libglu-9.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '978fc52725d1150274997b2e18343a61c1741e258f3932cb2c0aac3b956dbd3a',
     armv7l: '978fc52725d1150274997b2e18343a61c1741e258f3932cb2c0aac3b956dbd3a',
       i686: '68e3211a0c406b707b8cef7b6b1848af360db90270139c25a4403ef630b273e9',
     x86_64: '3eb2f46c684da6c34ab4f35b213d82be693afdb1203493a10f65edffeeb98cc7',
  })

  depends_on 'mesa'
  depends_on 'xorg_lib'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
