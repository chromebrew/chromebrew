require 'package'

class Miller < Package
  description 'Miller is like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON'
  homepage 'https://miller.readthedocs.io/'
  version '6.17.0'
  license 'Copyright (c) 2015 - John Kerl'
  compatibility 'all'

  source_url({
    aarch64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
     armv7l: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-armv7.tar.gz",
       i686: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-386.tar.gz",
     x86_64: "https://github.com/johnkerl/miller/releases/download/v#{version}/miller-#{version}-linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'f21057484e8de83963269052f4742dab9c173bca52c11aa25116861f6eafd4cf',
     armv7l: 'f21057484e8de83963269052f4742dab9c173bca52c11aa25116861f6eafd4cf',
       i686: 'a4b95fe8feb8c452b96eed957ee801640bd38f25f8be2609042055b88251dafd',
     x86_64: '5a3588754d42cea7f46c5fe38ce1bf50c6043e8eefe3656acf5bbd2fd86c1ea4'
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
