require 'package'

class Freeglut < Package
  description 'FreeGLUT is a free-software/open-source alternative to the OpenGL Utility Toolkit (GLUT) library.'
  homepage 'http://freeglut.sourceforge.net/'
  version '3.2.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/freeglut/freeglut/3.2.1/freeglut-3.2.1.tar.gz'
  source_sha256 'd4000e02102acaf259998c870e25214739d1f16f67f99cb35e4f46841399da68'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freeglut-3.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freeglut-3.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freeglut-3.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freeglut-3.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '49c22c36b1c02bd9ea8b439e05ce83d25ff2b0bec96da91366f57500abaafc57',
     armv7l: '49c22c36b1c02bd9ea8b439e05ce83d25ff2b0bec96da91366f57500abaafc57',
       i686: '7df49b8ae79cbb1db19a01ba656c652d04a19a236f749ef1246190e8c1b04a68',
     x86_64: 'f834844fb8a0afb528d602513bef51306afcba74f8361707f28d052d8e28d4d7',
  })

  depends_on 'libglu'

  def self.build
    system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=release"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
