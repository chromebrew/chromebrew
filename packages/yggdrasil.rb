require 'package'

class Yggdrasil < Package
  description 'Overlay network implementation of a new routing scheme for mesh networks.'
  homepage 'https://yggdrasil-network.github.io/'
  version '0.4.7'
  license 'LGPLv3'
  compatibility 'all'
  source_url 'https://github.com/yggdrasil-network/yggdrasil-go.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yggdrasil/0.4.7_armv7l/yggdrasil-0.4.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yggdrasil/0.4.7_armv7l/yggdrasil-0.4.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yggdrasil/0.4.7_i686/yggdrasil-0.4.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yggdrasil/0.4.7_x86_64/yggdrasil-0.4.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '127c621b87747f904cc5abc6b50b58ad078fdb4ed628e6e13dd543c31536c766',
     armv7l: '127c621b87747f904cc5abc6b50b58ad078fdb4ed628e6e13dd543c31536c766',
       i686: '5e9c9a0883f3c10ecc781e7c9d1ce0dc7d23bbb6d2c5760d649bb9820950e605',
     x86_64: '498a420d75649b961dc859b8de67d4850e0f2536de69ff609f71183ef0306dc6'
  })

  depends_on 'go' => :build

  def self.patch
    # For some reason the version is not returned; hence this patch.
    system "sed -i 's,return \"unknown\",return \"#{version}\",' src/version/version.go"
  end

  def self.build
    system './build'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install %w[yggdrasil yggdrasilctl], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
