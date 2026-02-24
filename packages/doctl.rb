require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.151.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62877f6c801aa6012f9f4ec6c0bdb40dad5f318f7e5a44bb9af644f7435c7c0e',
     armv7l: '62877f6c801aa6012f9f4ec6c0bdb40dad5f318f7e5a44bb9af644f7435c7c0e',
       i686: '02cbeae614392dcb2994f1d1a7c206d3b03ae632f8f1460f7315a7a955487ca8',
     x86_64: '8fcd7592a356230b1eca85ee1f4f0b991890b1fc23131cfdb0abf9311311f004'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
