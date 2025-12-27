require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.83'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'f25ab2e2285ad049b285465e82c76549839e7729f43cda6a317e70b48cbf387f',
     armv7l: 'f25ab2e2285ad049b285465e82c76549839e7729f43cda6a317e70b48cbf387f',
       i686: '0f1b3f9b41c8a37310925fb162a1234fbfdc465a3302eb2bfc3de63657fa28dd',
     x86_64: 'ed37d29fc117b3075cf586bb9323ec6c16320a5a3c5c0df9f1859d271d303f0d'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
