require 'package'

class Armadillo < Package
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'http://arma.sourceforge.net/'
  version '8.400.0'

  source_url 'http://sourceforge.net/projects/arma/files/armadillo-8.400.0.tar.xz'
  source_sha256 '5cb6bc2f457a9d6a0758cfb15c418d48289909daccd79d0e428452029285dd9b'

  depends_on 'gcc' => :build
  depends_on 'openblas'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
