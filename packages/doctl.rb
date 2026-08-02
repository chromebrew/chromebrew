require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.166.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcfc276fefd107fee4bfae7ebc9c8cdad1bced8616787b49af28882a392d38ac',
     armv7l: 'bcfc276fefd107fee4bfae7ebc9c8cdad1bced8616787b49af28882a392d38ac',
       i686: 'bc53dad60c77e0dce67e4d10b88977f601683946bf714c2550588418c1e01692',
     x86_64: 'a71e9e1b85b3f8a87f56ff21cabeba0a3e182621934f2c15fdd872ed50c7c43f'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
