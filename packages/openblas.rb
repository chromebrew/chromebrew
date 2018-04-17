require 'package'

class Openblas < Package
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.2.20'

  source_url 'https://github.com/xianyi/OpenBLAS/archive/v0.2.20.zip'

  source_sha256 'bb5499049cf60b07274740a4ddd756daa0fe2c817d981d7fe7e5898dcf411fdc'

  depends_on 'unzip' => :build

  def self.build
    system "make"
  end

  def self.install
    system "make",
           "DESTDIR=#{CREW_DEST_DIR}",
           "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "install"
  end
end
