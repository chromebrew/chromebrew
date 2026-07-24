require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.164.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3679526573d71a5d078ca35f921a17119e9bc7e99280e64ec4328a8786d07726',
     armv7l: '3679526573d71a5d078ca35f921a17119e9bc7e99280e64ec4328a8786d07726',
       i686: 'f818acf726f7bf217f4eb6372e66453fcbb3ab05ad99f7900b114bc4be524721',
     x86_64: '3a66247da17df7e77bc772b4446d050e103d797e5c1565f780e4d44afa234630'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
