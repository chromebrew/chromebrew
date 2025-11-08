require 'package'

class Go_containerregistry < Package
  description 'Go library and CLIs for working with container registries'
  homepage 'https://github.com/google/go-containerregistry'
  version '0.20.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
     armv7l: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
       i686: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_i386.tar.gz",
     x86_64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '6c7c80b4e9d7ea683b0b6267776d094d24ce7ec3dca3e0f43ce18a80a1b84e86',
     armv7l: '6c7c80b4e9d7ea683b0b6267776d094d24ce7ec3dca3e0f43ce18a80a1b84e86',
       i686: 'efca5a8d3d59a9a58fc91bafa26921c2f90dc0e26a88428807fe237eb85ec448',
     x86_64: 'c1d593d01551f2c9a3df5ca0a0be4385a839bd9b86d4a76e18d7b17d16559127'
  })

  no_compile_needed

  def self.install
    FileUtils.install %w[crane gcrane krane], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
