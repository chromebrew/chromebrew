require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.159.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5cd8ca226d27e794dc5bd5da42efd571d77533b671d56571a89e963b7c7dd689',
     armv7l: '5cd8ca226d27e794dc5bd5da42efd571d77533b671d56571a89e963b7c7dd689',
       i686: '217312a089ae66af26cccda7bbaf411d751a4101679908593bb2e2507dcb52f5',
     x86_64: '33a769e26787dc66e17b0b5a33a1c1b801494ce6b55818ec3556ece296bd2be0'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
