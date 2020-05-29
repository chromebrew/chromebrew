require 'package'

class Ripgrep < Package
  description 'ripgrep recursively searches directories for a regex pattern'
  homepage 'https://github.com/BurntSushi/ripgrep'
  version '12.1.0'
  compatibility 'all'
  source_url 'https://github.com/BurntSushi/ripgrep/archive/12.1.0.tar.gz'
  source_sha256 'ca2d11dd7b7346734d47ad8073468e9c409fbe85842a608d372b8d4fb36be291'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ripgrep-12.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ripgrep-12.1.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ripgrep-12.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3a258a81559b077d04cf3d9912731da26d2f8398538e9a9faa3fb3e0a15aa6cd',
     armv7l: '3a258a81559b077d04cf3d9912731da26d2f8398538e9a9faa3fb3e0a15aa6cd',
     x86_64: '1e1b614726be5ad7de8e35921d8ea73c0fd72f4cd3d245b5dae78e356055e17b',
  })

  depends_on 'rust'

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
      system 'rustup toolchain install 1.43.1-armv7-unknown-linux-gnueabihf'
      system 'rustup default 1.43.1-armv7-unknown-linux-gnueabihf'
    else
      system 'rustup toolchain install stable'
      system 'rustup default stable'
    end
    system 'cargo build --release'
  end

  def self.check
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    system 'cargo test --all'
  end

  def self.install
    system "install -Dm755 target/release/rg #{CREW_DEST_PREFIX}/bin/rg"
  end

  def self.postinstall
    puts
    puts "Type 'rg' to get started.".lightblue
    puts
  end
end
