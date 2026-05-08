require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.158.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '695fd166f6ff6749c934796c4fcd24d7e02ab18f829c323477e02ce6b7532349',
     armv7l: '695fd166f6ff6749c934796c4fcd24d7e02ab18f829c323477e02ce6b7532349',
       i686: 'f734cd62a6d6afe56164a16b3a8d7fa97b7e35db06900744bb7730bcf4d74260',
     x86_64: 'f2692a3df926da7ea94581a3b4261d81c94047681100592e17c128921108b1e3'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
