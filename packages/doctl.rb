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
    aarch64: '51507b3971ec8c669b1c088b5199ef0e14b493bcb924b43747aca3b477eaba41',
     armv7l: '51507b3971ec8c669b1c088b5199ef0e14b493bcb924b43747aca3b477eaba41',
       i686: '728fa91dad141c1f9268924099810f532bb601d394a2d316e721752244a4c2f6',
     x86_64: 'b912b691355f35ddd3ae0a0f5cd46df2707222f6248c1304b25f3dbe4cecd694'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
