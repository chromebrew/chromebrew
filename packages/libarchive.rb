require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version '3.4.2'
  source_url 'https://www.libarchive.org/downloads/libarchive-3.4.2.tar.gz'
  source_sha256 'b60d58d12632ecf1e8fad7316dc82c6b9738a35625746b47ecdcaf4aed176176'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    system "./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
