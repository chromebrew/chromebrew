require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.97'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '91a173f85868e52cd84535f75ec3545475d4b6ae6b87f1c8736fac4afc71a22b',
     armv7l: '91a173f85868e52cd84535f75ec3545475d4b6ae6b87f1c8736fac4afc71a22b',
       i686: '932630723707ea0d8fc859e58ab37088938f9f977233f6548b80a88997e82790',
     x86_64: '67b4976a56f33ea7870b798912e738ec44eef38e7578ae7b532f2def1c73a5ad'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
