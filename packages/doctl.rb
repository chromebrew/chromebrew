require 'package'

class Doctl < Package
  description 'The official command line interface for the DigitalOcean API.'
  homepage 'https://github.com/digitalocean/doctl'
  version '1.155.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c126ecffc0b63f1c1d7b442fabac88411160b55dce8d6176a14ab189b4ebf1b2',
     armv7l: 'c126ecffc0b63f1c1d7b442fabac88411160b55dce8d6176a14ab189b4ebf1b2',
       i686: 'dda276750e47c64684034dc9f30d34046cd4a44b8be2fd9526e02e5d6314447d',
     x86_64: 'c8594ac31a23f150b8c382da08d001a447e9bbe0e62e5497ba8b9f7a5505933b'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/digitalocean/doctl/cmd/doctl@v#{version}"
  end
end
