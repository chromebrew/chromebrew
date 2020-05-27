require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '0.9.0'
  source_url 'https://github.com/cli/cli/archive/v0.9.0.tar.gz'
  source_sha256 '318295e5a662f785662751f1e2cd4b1f613ec3aced1c4e7f1755d27922dbfdbf'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'go' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 bin/gh #{CREW_DEST_PREFIX}/bin/gh"
  end
end
