require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://github.com/cli/cli/archive/v1.0.0.tar.gz'
  source_sha256 'e3d1c341829f5b885dce9aa2bf4bc84db48072752250f6fdb2d62903caf07cfb'

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

  def self.postinstall
    puts
    puts "Type 'gh' to get started.".lightblue
    puts
  end
end
