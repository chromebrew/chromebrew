require 'package'

class Miller < Package
  description 'Miller is like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON'
  homepage 'https://miller.readthedocs.io/'
  version '6.21.0'
  license 'Copyright (c) 2015 - John Kerl'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
     armv7l: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
       i686: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-386.tar.gz",
     x86_64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'e7188138b39e41170b4ddb2f3089bcb5e277c3c455a8f8cfc8e58d823a0ecc87',
     armv7l: 'e7188138b39e41170b4ddb2f3089bcb5e277c3c455a8f8cfc8e58d823a0ecc87',
       i686: '4a3509b9e6ed553a7ae1286080b119f891ad0e3da3eac56e76a1ebfb9bae7e69',
     x86_64: '22daf43f3afc7c497da0b9480a0d4ef0d39c9bf68b2460068dd0187ed44f7b80'
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
