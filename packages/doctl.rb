require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.160.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '531d55c6d4c488f9a870a53e4572cc44eea7ce795d92d40e05a1cc5d04a21bc8',
     armv7l: '531d55c6d4c488f9a870a53e4572cc44eea7ce795d92d40e05a1cc5d04a21bc8',
       i686: '6afc81e1bf1547fd4ead89447a0e96108c5720e6e79f1c08dab255f39f13f7d4',
     x86_64: '45752f12c0b28e313f16e23e29ca0e1207eb0a34e2e2e3029110da15ad15f17d'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
