require 'package'

class Armadillo < Package
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'http://arma.sourceforge.net/'
  version '8.400.0'
  source_url 'https://downloads.sourceforge.net/project/arma/armadillo-8.400.0.tar.xz'
  source_sha256 '5cb6bc2f457a9d6a0758cfb15c418d48289909daccd79d0e428452029285dd9b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/armadillo-8.400.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/armadillo-8.400.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/armadillo-8.400.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/armadillo-8.400.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '97a7f23c22e8dcd9b92806918bd2a5f7a72230f8b16033ca3dfc6ebebc8fc2f5',
     armv7l: '97a7f23c22e8dcd9b92806918bd2a5f7a72230f8b16033ca3dfc6ebebc8fc2f5',
       i686: 'bbefa4f2c66db16180c367d4e6bb568cbcf9abd5d26b19266f9d744e93ebda9c',
     x86_64: 'd2dc68a222aa585676e5ea325970ded3015ad817027aca890199bc7f5c090799',
  })

  depends_on 'openblas'

  def self.build
    system "./configure",
           "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
           "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make",
           "DESTDIR=#{CREW_DEST_DIR}",
           "install"
  end
end
