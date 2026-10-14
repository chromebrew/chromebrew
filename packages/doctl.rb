require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.185.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f271ae49e45e12a1d372707bf223252e565c8c71653b440ce9d43f43cced6208',
     armv7l: 'f271ae49e45e12a1d372707bf223252e565c8c71653b440ce9d43f43cced6208',
       i686: '12bb893ba036a90c1955f02c1aa222ed201bb8e0c969498a607df9675e4d2798',
     x86_64: 'a7a6508dc9cc4dd8d511ea21e16dc5476a08448c4dca9fd04014d2dcc4aa021e'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
