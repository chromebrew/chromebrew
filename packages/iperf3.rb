require 'package'

class Iperf3 < Package
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.7'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/esnet/iperf/archive/3.7.tar.gz'
  source_sha256 'c349924a777e8f0a70612b765e26b8b94cc4a97cc21a80ed260f65e9823c8fc5'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b58c66a6ac474fff36e1336194fb0e8b9fac68ccd7bcb8b083e85c48d4d7011e',
     armv7l: 'b58c66a6ac474fff36e1336194fb0e8b9fac68ccd7bcb8b083e85c48d4d7011e',
       i686: 'ddf4ec2075b93914bb9d05054d825d988d0c539cc520ba7af271e151597b6b94',
     x86_64: '790a85d3e616b4e02b05c43c6e2ae31d0f8e100a6020f060279ba7dec427c8f5'
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
