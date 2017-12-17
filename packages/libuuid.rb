require 'package'

class Libuuid < Package
  description 'Portable uuid C library'
  homepage 'https://sourceforge.net/projects/libuuid/'
  version '1.0.3'
  source_url 'https://downloads.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz'
  source_sha256 '46af3275291091009ad7f1b899de3d0cea0252737550e7919d17237997db5644'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
