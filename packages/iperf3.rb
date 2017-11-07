require 'package'

class Iperf3 < Package
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.2'
  source_url 'https://github.com/esnet/iperf/archive/3.2.tar.gz'
  source_sha256 'cb20d3a33e07a3b45a49a358b044f4998f452ef9d1a8a5cbde476b6ab9e9b526'

  binary_url ({
  })
  binary_sha256 ({
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
