require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.149.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8174fca1e1f98087c0b2f90fc6e4cc8384971bfdc70950c80f5419603b14031',
     armv7l: 'a8174fca1e1f98087c0b2f90fc6e4cc8384971bfdc70950c80f5419603b14031',
       i686: 'b5d3c51cd87a8c31b625ac1c96abe7a969218eb88d79dfca66f1b947d6095b14',
     x86_64: '8d4b8cb0c3000904113c1afcf77449c1df9b3f201c4b75c46abce7781b05d42a'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
