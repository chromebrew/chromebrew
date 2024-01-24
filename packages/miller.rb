require 'package'

class Miller < Package
  description 'Miller is like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON'
  homepage 'https://miller.readthedocs.io/'
  version '6.11.0'
  license 'Copyright (c) 2015 - John Kerl'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/johnkerl/miller/releases/download/v6.11.0/miller-6.11.0-linux-armv7.tar.gz',
     armv7l: 'https://github.com/johnkerl/miller/releases/download/v6.11.0/miller-6.11.0-linux-armv7.tar.gz',
       i686: 'https://github.com/johnkerl/miller/releases/download/v6.11.0/miller-6.11.0-linux-386.tar.gz',
     x86_64: 'https://github.com/johnkerl/miller/releases/download/v6.11.0/miller-6.11.0-linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'b093614f5248fa3177f8e5ac6bb5a91d8ccf5e06905aaf83bfe465faccc8b0b7',
     armv7l: 'b093614f5248fa3177f8e5ac6bb5a91d8ccf5e06905aaf83bfe465faccc8b0b7',
       i686: 'a84a1aa97ebfc4de33f2151d513aebcdeb140ad90519ed826f3270cf49fe9b99',
     x86_64: '10671d5129d12230f296d5cb7fa20f9974d9f8b6052c9861fb20c333d2c2c04b'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'mlr', "#{CREW_DEST_PREFIX}/bin/mlr", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'mlr help' to get started.\n".lightblue
  end
end
