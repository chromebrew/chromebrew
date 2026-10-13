require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.183.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc05b0277d95c1f6e7be35df253dcbea4636a84cfd5570fffce9a76a58083bce',
     armv7l: 'cc05b0277d95c1f6e7be35df253dcbea4636a84cfd5570fffce9a76a58083bce',
       i686: 'a84fbb51e131eadfd272fecd57880bd35273a48d16bc7d0790178b1cfa811f50',
     x86_64: '6a7500695b013114bbc7b56be8b5934b96e1e5fb602a068486d9aea539dd1da7'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
