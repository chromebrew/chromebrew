require 'package'

class Iperf3 < Package
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.2'
  source_url 'https://github.com/esnet/iperf/archive/3.2.tar.gz'
  source_sha256 'cb20d3a33e07a3b45a49a358b044f4998f452ef9d1a8a5cbde476b6ab9e9b526'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/iperf3-3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/iperf3-3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/iperf3-3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/iperf3-3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6639e92af758fc912b98cf5bf0d8a6493809ce6f19bff1996e78b5c5847dda6',
     armv7l: 'b6639e92af758fc912b98cf5bf0d8a6493809ce6f19bff1996e78b5c5847dda6',
       i686: '4f8ff2a571c31bff3c61a2d2f40a34946f70146cc581a4a06a7dcf47e44bbf09',
     x86_64: '85870ca894afe74c83aeb6ffeab38da027a6a75eae6451f16afb964c0063a653',
  })

  def self.build
    system "./configure",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--prefix=#{CREW_PREFIX}",
      "--disable-dependency-tracking",
      "--disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
