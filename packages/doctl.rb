require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.162.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5d960e2110dd64db348240271e7cd53fa16384858ad6384614a885dab152197',
     armv7l: 'c5d960e2110dd64db348240271e7cd53fa16384858ad6384614a885dab152197',
       i686: 'b3d95d39ea90e1e70f7e1d36519e16dbaf8b3cbfee843b69eec7266ac6b98a62',
     x86_64: 'cfaadc95751cddc4ab5a2434da95e5b900f219b402bb04f18259e1e5410df76f'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
