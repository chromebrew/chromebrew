require 'package'

class Miller < Package
  description 'Miller is like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON'
  homepage 'https://miller.readthedocs.io/'
  version '6.20.2'
  license 'Copyright (c) 2015 - John Kerl'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
     armv7l: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
       i686: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-386.tar.gz",
     x86_64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '4e1bc6240340b7adc944ddda33463f6fb788c6ae0d195713ab0a38ae7a5135ed',
     armv7l: '4e1bc6240340b7adc944ddda33463f6fb788c6ae0d195713ab0a38ae7a5135ed',
       i686: 'fbd1b135834ad91db180fe00619a2f11042c6b5869a1b04aaa2be511a1b6c5cd',
     x86_64: '73461cd6469df3a0c14a102d6e19ef04528eda08cbd7aedbce5d32ccc7c0428e'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'mlr', "#{CREW_DEST_PREFIX}/bin/mlr", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'mlr help' to get started.\n"
  end
end
