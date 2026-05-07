require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.157.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c451eb47bc6ceb2d398dcaecd81cac9a84af94f4d293d0b19365c77aef18dd5e',
     armv7l: 'c451eb47bc6ceb2d398dcaecd81cac9a84af94f4d293d0b19365c77aef18dd5e',
       i686: '63865850b016f2f924e478ab1a26449a02a2071c6e75d33ce1225acee474f7d5',
     x86_64: 'c109caaad4ce8dd7e98dde99a5682a151877afc09b2b3c4d3d2aa79da6d10a1f'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
