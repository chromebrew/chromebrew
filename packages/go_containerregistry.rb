require 'package'

class Go_containerregistry < Package
  description 'Go library and CLIs for working with container registries'
  homepage 'https://github.com/google/go-containerregistry'
  version '0.20.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
     armv7l: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
       i686: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_i386.tar.gz",
     x86_64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'c3cc97792ecb9657f5e21bd5cddd8735c12e44bffa453d6319231909a5b11ce1',
     armv7l: 'c3cc97792ecb9657f5e21bd5cddd8735c12e44bffa453d6319231909a5b11ce1',
       i686: '53bc1396c2242acace770827e4999edace0b546e2c1f7681587f127d75855d73',
     x86_64: 'c14340087103ba9dadf61d45acd20675490fd0ccbd56ac7901fc1b502137f44b'
  })

  no_compile_needed

  def self.install
    FileUtils.install %w[crane gcrane krane], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
