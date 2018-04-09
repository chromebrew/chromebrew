require 'package'

class Daq < Package
  description 'Data Acquisition library, for packet I/O.'
  homepage 'https://www.snort.org'
  version '2.0.6'
  source_url 'https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz'
  source_sha256 'd41da5f7793e66044e6927dd868c0525e7ee4ec1a3515bf74ef9a30cd9273af0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpcap'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
