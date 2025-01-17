require 'package'

class Go_containerregistry < Package
  description 'Go library and CLIs for working with container registries'
  homepage 'https://github.com/google/go-containerregistry'
  version '0.20.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
     armv7l: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
       i686: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_i386.tar.gz",
     x86_64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '3a6bd364b5251651b0e7fcd01675fe32f29072fb1b194dc061fd5b835ea2cca6',
     armv7l: '3a6bd364b5251651b0e7fcd01675fe32f29072fb1b194dc061fd5b835ea2cca6',
       i686: 'aa2ca12fc4cab173c246aa5352dd987ba030a1ef7201e7988adda3c575819770',
     x86_64: '36c67a932f489b3f2724b64af90b599a8ef2aa7b004872597373c0ad694dc059'
  })

  no_compile_needed

  def self.install
    FileUtils.install %w[crane gcrane krane], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
