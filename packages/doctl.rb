require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.181.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2693b626a45a0888be67b1b715b3c1299ccded9a5cc91ed29051377f732fbc0',
     armv7l: 'a2693b626a45a0888be67b1b715b3c1299ccded9a5cc91ed29051377f732fbc0',
       i686: 'aa28a082628899ed37492bffb42b49fcc517506fa6cf8a40f4a62e50001bc5ac',
     x86_64: 'da8cf4ca98e7362c4cb98887ae8cefc0bcf80299ce3794626ba9e3495d338e8d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
