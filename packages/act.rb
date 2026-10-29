require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.92'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'dc69e879ce9f826b5e8849f2a3987e89fb7f66de6223ec98afeefe536285e317',
     armv7l: 'dc69e879ce9f826b5e8849f2a3987e89fb7f66de6223ec98afeefe536285e317',
       i686: '1fbc83bb86dcc97890f80a62092de889087c0130724bf4424cf3f513a837cd8f',
     x86_64: 'c9e13f0eb77948a6d02eb2e06fa7220addfc5b9927ed2a1b35bcdae5441ac7a1'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
