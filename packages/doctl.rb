require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.153.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59b637d9d7634d3ddfd5210f3d7eea37191fb5b3c39ed6e1eb2d1ae4538fe70f',
     armv7l: '59b637d9d7634d3ddfd5210f3d7eea37191fb5b3c39ed6e1eb2d1ae4538fe70f',
       i686: '1b15d365c4e5559ba6ab05e5c6d8d42414b1844d3c9491ae440fa87047e7bfd5',
     x86_64: '63bcd537117078bd856ed9792a58cd768aea22db115fc65b1c21bdc6262526dc'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
