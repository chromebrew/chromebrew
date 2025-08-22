require 'package'

class Miller < Package
  description 'Miller is like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON'
  homepage 'https://miller.readthedocs.io/'
  version '6.15.0'
  license 'Copyright (c) 2015 - John Kerl'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
     armv7l: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
       i686: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-386.tar.gz",
     x86_64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '896a161140ef86e9f1e285eb04ca5bc5688291392afb1e003c7221d3cf810ff0',
     armv7l: '896a161140ef86e9f1e285eb04ca5bc5688291392afb1e003c7221d3cf810ff0',
       i686: '547cc8d01f4a16ece03c7bd1c38e0dabbb2f36fc32eb8d5d98ef2ec31c7f7479',
     x86_64: '9a2f0a2957fdd2eace2ea872dad2c3c3e0bee40e1042aad0996f03b1d7abc7cc'
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
