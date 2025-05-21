require 'buildsystems/autotools'

class Iperf3 < Autotools
  description 'iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks.'
  homepage 'https://iperf.fr'
  version '3.19'
  license 'BSD-3'
  compatibility 'all'
  source_url "https://github.com/esnet/iperf/archive/refs/tags/#{version}.tar.gz"
  source_sha256 'da5cff29e4945b2ee05dcf9a0c67768cc000dc1b122935bce3492c4e36f6b5e9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b58c66a6ac474fff36e1336194fb0e8b9fac68ccd7bcb8b083e85c48d4d7011e',
     armv7l: 'b58c66a6ac474fff36e1336194fb0e8b9fac68ccd7bcb8b083e85c48d4d7011e',
       i686: 'ddf4ec2075b93914bb9d05054d825d988d0c539cc520ba7af271e151597b6b94',
     x86_64: '790a85d3e616b4e02b05c43c6e2ae31d0f8e100a6020f060279ba7dec427c8f5'
  })

  configure_options '--disable-maintainer-mode'
end
