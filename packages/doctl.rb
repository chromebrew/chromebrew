require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.174.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '332f576007813e2fe528ec5602fa8d57e672324d7686e05df1000875e0185cab',
     armv7l: '332f576007813e2fe528ec5602fa8d57e672324d7686e05df1000875e0185cab',
       i686: 'e1e1d9e46760d1d103634304732d9e982d1f2fe1ed2d27ed5671178ff1bca6f7',
     x86_64: 'b65d9bf2475f0c246721ed587748373abec56026f8f6a9a471e936e44bdc3f0e'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
