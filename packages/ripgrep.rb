require 'package'

class Ripgrep < Package
  description 'ripgrep recursively searches directories for a regex pattern'
  homepage 'https://github.com/BurntSushi/ripgrep'
  version '12.0.1'
  source_url 'https://github.com/BurntSushi/ripgrep/archive/12.0.1.tar.gz'
  source_sha256 '5be34aa77a36ac9d8f1297a0d97069e4653e03f61c67d192cee32944cd2b6329'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'rust'

  def self.build
    case ARCH
    when 'aarch64'
      system 'rustup toolchain install 1.25.0-aarch64-unknown-linux-gnu'
      system 'rustup default 1.25.0-aarch64-unknown-linux-gnu'
    when 'armv7l'
      system 'rustup toolchain install 1.25.0-armv7-unknown-linux-gnueabihf'
      system 'rustup default 1.25.0-armv7-unknown-linux-gnueabihf'
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
