require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.168.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '867be3437a75ebd3cd4e450a4c3b67c3b86afd6894177595b47cd93d85eb1c74',
     armv7l: '867be3437a75ebd3cd4e450a4c3b67c3b86afd6894177595b47cd93d85eb1c74',
       i686: '7be0a6f7eabde72bc11a7285d4985c3c86703932647d5821e0649cd5ca834eb7',
     x86_64: 'b65e163a7e7f9c61a50fc660501c758dff3908e85007c2e77cf76b800e3dac77'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
