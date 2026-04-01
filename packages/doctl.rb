require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.154.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d96479e0066bfb8099c6ef8b6689521da33c18243ba06201a90bfc104c04d8c',
     armv7l: '5d96479e0066bfb8099c6ef8b6689521da33c18243ba06201a90bfc104c04d8c',
       i686: 'e516555ee86b65f0c75a1659eed0d19599b56b8b40451937d6ae2f28a01a1112',
     x86_64: 'c1e06f4ffa44be8d9b51d648cf0ca5fffac4124c98d388bc3cdfa47ea071b6d5'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
