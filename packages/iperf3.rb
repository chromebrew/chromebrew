require 'package'

class Iperf3 < Package
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.7'
  source_url 'https://github.com/esnet/iperf/archive/3.7.tar.gz'
  source_sha256 'c349924a777e8f0a70612b765e26b8b94cc4a97cc21a80ed260f65e9823c8fc5'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
      "--libdir=#{CREW_LIB_PREFIX}",
      "--prefix=#{CREW_PREFIX}",
      '--disable-dependency-tracking',
      '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
