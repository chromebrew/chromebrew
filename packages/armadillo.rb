require 'package'

class Armadillo < Package
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'http://arma.sourceforge.net/'
  version '8.400.0'

  source_url 'https://downloads.sourceforge.net/project/arma/armadillo-8.400.0.tar.xz'
  source_sha256 '5cb6bc2f457a9d6a0758cfb15c418d48289909daccd79d0e428452029285dd9b'

  depends_on 'cmake' => :build
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
