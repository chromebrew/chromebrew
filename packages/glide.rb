require 'package'

class Glide < Package
  description 'Package Management for Golang'
  homepage 'https://glide.sh/'
  version %w[i686 x86_64].include?(ARCH) ? '0.13.3' : '0.13.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/Masterminds/glide/releases/download/v#{version}/glide-v#{version}-linux-armv7.tar.gz",
     armv7l: "https://github.com/Masterminds/glide/releases/download/v#{version}/glide-v#{version}-linux-armv7.tar.gz",
       i686: "https://github.com/Masterminds/glide/releases/download/v#{version}/glide-v#{version}-linux-386.tar.gz",
     x86_64: "https://github.com/Masterminds/glide/releases/download/v#{version}/glide-v#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'f24ee06dc1bfaf8e2651f65845efa80991498b91602c8f7f04f628d2995b2163',
     armv7l: 'f24ee06dc1bfaf8e2651f65845efa80991498b91602c8f7f04f628d2995b2163',
       i686: 'cb1a707a83a63b26cf6d4d911925046e251dd358b4045731c041521ee19b9e77',
     x86_64: 'ba5619955a28d7931a9ae38d095fc5fa5acc28e77abc8737a8136c652d9cbb38'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'glide', "#{CREW_DEST_PREFIX}/bin/glide", mode: 0o755
  end
end
