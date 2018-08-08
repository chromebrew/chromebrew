require 'package'

class Armadillo < Package
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'http://arma.sourceforge.net/'
  version '8.600.0'
  source_url 'https://sourceforge.net/projects/arma/files/armadillo-8.600.0.tar.xz'
  source_sha256 '5f00c735e97fc23c910a225d1b6db9541af76022cc74f9b8b327dfa347926b40'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'liblapack'
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
