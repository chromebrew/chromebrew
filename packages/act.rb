require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.89'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '50c65e5034a9a065b8937d2d9e3ad9418311d4f26348a8b9047f2190c89ccdc4',
     armv7l: '50c65e5034a9a065b8937d2d9e3ad9418311d4f26348a8b9047f2190c89ccdc4',
       i686: 'd1bdc91e33b94a86f078d90c32079660e0349ac8f56a94e23238a578b0cdb0f6',
     x86_64: '0191d6f1f3b716b5c55820032605d05fc3c1cdbf581ebeff655019e5dd1524c0'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
