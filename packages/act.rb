require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.71'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '5e6caeafc26777e56a2eb9230a4be92d8a1ff0ec44495946bd5eff76e5257fd3',
     armv7l: '5e6caeafc26777e56a2eb9230a4be92d8a1ff0ec44495946bd5eff76e5257fd3',
       i686: '53aa859c9317ad7475d3b8d01e1649c2fed04e3a12898027a24718ea733bc236',
     x86_64: 'f00cd2ca6310b73831042d01e3c2f00cb60c28620588e981bf551a0aca659dc5'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
