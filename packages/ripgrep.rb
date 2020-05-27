require 'package'

class Ripgrep < Package
  description 'ripgrep recursively searches directories for a regex pattern'
  homepage 'https://github.com/BurntSushi/ripgrep'
  version '12.1.0'
  source_url 'https://github.com/BurntSushi/ripgrep/archive/12.1.0.tar.gz'
  source_sha256 'ca2d11dd7b7346734d47ad8073468e9c409fbe85842a608d372b8d4fb36be291'

  binary_url ({
  })
  binary_sha256 ({
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
    system 'cargo test --all'
  end

  def self.install
    system "install -Dm755 target/release/rg #{CREW_DEST_PREFIX}/bin/rg"
  end
end
