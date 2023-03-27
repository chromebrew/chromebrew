require 'package'

class Go_containerregistry < Package
  description 'Go library and CLIs for working with container registries'
  homepage 'https://github.com/google/go-containerregistry'
  version '0.14.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/google/go-containerregistry/releases/download/v0.14.0/go-containerregistry_Linux_armv6.tar.gz',
     armv7l: 'https://github.com/google/go-containerregistry/releases/download/v0.14.0/go-containerregistry_Linux_armv6.tar.gz',
       i686: 'https://github.com/google/go-containerregistry/releases/download/v0.14.0/go-containerregistry_Linux_i386.tar.gz',
     x86_64: 'https://github.com/google/go-containerregistry/releases/download/v0.14.0/go-containerregistry_Linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: '81ea3959bb83e26abcfdacb6bde5775c68f4dc0a0c2dbc08078091e2470a286e',
     armv7l: '81ea3959bb83e26abcfdacb6bde5775c68f4dc0a0c2dbc08078091e2470a286e',
       i686: '68bcdf86458a5177c827bbb8209f6d839e06bb86840702409324bfd591d54ff4',
     x86_64: '5b68fe0f7fe9170ba3e1677f47ecfc892c687a2fdcbc2b1de39ab5e9663de5d7'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install %w[crane gcrane krane], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
