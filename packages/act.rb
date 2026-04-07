require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.87'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '65e59643a65cd02ec1957967e1f98222e15af0d8c714a4954a63785909b4495e',
     armv7l: '65e59643a65cd02ec1957967e1f98222e15af0d8c714a4954a63785909b4495e',
       i686: 'a0b13bd15a1fa5bf0535783189a3e3458e9255833ef8975c5cf270f971f96689',
     x86_64: '9bbfca7d779f71746233ec65e47fdcb12c4c976c1c97ec085956976fcabee866'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
