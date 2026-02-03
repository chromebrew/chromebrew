require 'package'

class Miller < Package
  description 'Miller is like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON'
  homepage 'https://miller.readthedocs.io/'
  version '6.16.0'
  license 'Copyright (c) 2015 - John Kerl'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
     armv7l: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
       i686: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-386.tar.gz",
     x86_64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: '2e25d1547f934c84160d04c66cc18d4df9e12eca4348d7995745e542868c6f07',
     armv7l: '2e25d1547f934c84160d04c66cc18d4df9e12eca4348d7995745e542868c6f07',
       i686: 'dff1e458cd2d900bb9b87857f584061299e7f4dac63e12a9979ca6334ee2f4c2',
     x86_64: '4512c5d9459c1d79d0ebc1a51af36e7044f27d2798cd7fb6764dfb953210b607'
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
