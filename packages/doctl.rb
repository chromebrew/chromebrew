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
    aarch64: 'f5e899e9d698df33c166ad102a28ba72d423a97c236ab90ce04a3f45f59ca96b',
     armv7l: 'f5e899e9d698df33c166ad102a28ba72d423a97c236ab90ce04a3f45f59ca96b',
       i686: '69872711548111e497402d3939b0f2440778f6cd6fcf367a5afa09b84751f740',
     x86_64: '084a1904dfe83b61be71b4238c77b20df6664ac24210fcdb895790ae365e7bdd'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
