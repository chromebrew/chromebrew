require 'package'

class Go_containerregistry < Package
  description 'Go library and CLIs for working with container registries'
  homepage 'https://github.com/google/go-containerregistry'
  version '0.20.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
     armv7l: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
       i686: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_i386.tar.gz",
     x86_64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'd3f059aa0b025eb6721ec1d8f39672eeff526b6decbdc5837a19fc40254c35f7',
     armv7l: 'd3f059aa0b025eb6721ec1d8f39672eeff526b6decbdc5837a19fc40254c35f7',
       i686: 'eefc49473b3bb4679a9dafb1ab75f170f2e695e147a13c877498b795cec65ea8',
     x86_64: '601ab53cf39e9fef3cf67ecb488ba6187a64f7209ccbd3308447291f7843f0b2'
  })

  no_compile_needed

  def self.install
    FileUtils.install %w[crane gcrane krane], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
