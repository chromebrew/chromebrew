require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.96'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '807931bd5f7307f61f538d07aae5e16efd9e2627e447d9b827fb26af891b9445',
     armv7l: '807931bd5f7307f61f538d07aae5e16efd9e2627e447d9b827fb26af891b9445',
       i686: 'e5f7b72dcc568c45a41786ce153e05ddf9dcff6c952969c6d0a90e7a3b0f2001',
     x86_64: 'b861e901c9062d841c6e8ecd36cdf27e0ce39ea0124cfd93de6efcebea0e16e7'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
