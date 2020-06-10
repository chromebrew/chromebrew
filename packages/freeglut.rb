require 'package'

class Freeglut < Package
  description 'FreeGLUT is a free-software/open-source alternative to the OpenGL Utility Toolkit (GLUT) library.'
  homepage 'http://freeglut.sourceforge.net/'
  version '3.0.0'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/freeglut/freeglut/3.0.0/freeglut-3.0.0.tar.gz'
  source_sha256 '2a43be8515b01ea82bcfa17d29ae0d40bd128342f0930cd1f375f1ff999f76a2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freeglut-3.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freeglut-3.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freeglut-3.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freeglut-3.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8a42e5a1693a57cb3ae0159e9c1e2a64dcf248077902b893dcd39aefd4100cf3',
     armv7l: '8a42e5a1693a57cb3ae0159e9c1e2a64dcf248077902b893dcd39aefd4100cf3',
       i686: 'cd7ac27ead67b3660bb18c037830a0e80bc3d87938c78eda15baa5ba682aef6e',
     x86_64: '00f1c07741619855037ed004f9ab6a5662fdbc500cb8180513fd39f289d668ea',
  })

  depends_on 'libglu'

  def self.build
    system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=release"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
