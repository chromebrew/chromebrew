require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '2.1.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d7473be53d373a5f7e012c9008eb6e474429312ab16bcbdc43fd4e1d28ed8ce',
     armv7l: '6d7473be53d373a5f7e012c9008eb6e474429312ab16bcbdc43fd4e1d28ed8ce',
       i686: 'b86e13802c6e0448f163342e5a77d50541ebfe9aaa9dcef825c77cfdc663e1ae',
     x86_64: '2a4a3eabea1ee25d8af8642cfd2278ff4ef89d1d3bbaae2e253c29673af8b2f4'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
