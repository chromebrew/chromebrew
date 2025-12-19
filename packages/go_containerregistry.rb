require 'package'

class Go_containerregistry < Package
  description 'Go library and CLIs for working with container registries'
  homepage 'https://github.com/google/go-containerregistry'
  version '0.20.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
     armv7l: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_armv6.tar.gz",
       i686: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_i386.tar.gz",
     x86_64: "https://github.com/google/go-containerregistry/releases/download/v#{version}/go-containerregistry_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'd8d6c91f6b0c4475406b12050b6a70841ad330af9f339945027147e99126baea',
     armv7l: 'd8d6c91f6b0c4475406b12050b6a70841ad330af9f339945027147e99126baea',
       i686: '9c8865fc6af4a4be62a64093ae9c2f6ed05f73ec32ed29cffa0bcd3ec0002986',
     x86_64: '8ef3564d264e6b5ca93f7b7f5652704c4dd29d33935aff6947dd5adefd05953e'
  })

  no_compile_needed

  def self.install
    FileUtils.install %w[crane gcrane krane], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
