require 'package'

class Siege < Package
  description 'Siege is an http load testing and benchmarking utility.'
  homepage 'https://www.joedog.org/siege-home/'
  version '4.0.4'
  source_url 'http://download.joedog.org/siege/siege-4.0.4.tar.gz'
  source_sha256 '8f7dcf18bd722bb9cc92bc3ea4b59836b4a2f8d8f01d4a94c8d181f56d91ea6f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'compressdoc' => :build
  depends_on 'diffutils' => :build
  depends_on 'openssl'
  depends_on 'perl'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end
end
