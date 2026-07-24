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
    aarch64: 'c989ce71a8560baaa81aa9284f823ea560a30c2c9f7d13cb9363ef906c8dabdd',
     armv7l: 'c989ce71a8560baaa81aa9284f823ea560a30c2c9f7d13cb9363ef906c8dabdd',
       i686: 'e905d5c45641286d1d1aa457f1ffb813bca7e066e7d91f51da5cc8e664ef76e7',
     x86_64: '6fe1f2a7643f04633db7af7db27530c3c3218f59f1afd11010a81c7bfc35ab0e'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
