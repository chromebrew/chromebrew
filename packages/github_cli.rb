require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://github.com/cli/cli/archive/v1.0.0.tar.gz'
  source_sha256 'e3d1c341829f5b885dce9aa2bf4bc84db48072752250f6fdb2d62903caf07cfb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/github_cli-1.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/github_cli-1.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/github_cli-1.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/github_cli-1.0.0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'f105f30044c96869f9f2c199a6907d7518ce69a6e7dc8de3059f2c2e1716d1e2',
     armv7l: 'f105f30044c96869f9f2c199a6907d7518ce69a6e7dc8de3059f2c2e1716d1e2',
       i686: 'b28ff38226112dcdb6c37b46fe8c84bbf28d709ae6d68ba102d2de4b72cf4a42',
     x86_64: '4949a7f29a571f59c8262f7b007a02cc238900d9999f10ad2941975fc2e3878b',

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
