require 'package'

class Asmc < Package
  description 'Asmc Macro Assembler'
  homepage 'https://github.com/nidud/asmc'
  license 'GPL-2.0'
  version '2.38'
  compatibility 'all'
  source_url 'https://github.com/nidud/asmc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2916448cb69f6e19dccd24e50b4418db76aab39f657b0b3d62be042a6371476',
     armv7l: 'a2916448cb69f6e19dccd24e50b4418db76aab39f657b0b3d62be042a6371476',
       i686: 'b9ed1b02d45dad14a9e013a0177f436ffce15844a2d8588afd895bb002126cbd',
     x86_64: '54473d9215b5e13215f7221e2692dd8d071b51d40926e301cc3cb2effb81c505'
  })

  def self.build
    system 'make', chdir: 'source/asmc'
  end

  def self.install
    FileUtils.install "bin/asmc#{CREW_LIB_SUFFIX}", "#{CREW_DEST_PREFIX}/bin/asmc", mode: 0o755
  end
end
