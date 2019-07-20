require 'package'

class Exa < Package
  description 'Modern replacement for \'ls\''
  homepage 'https://the.exa.website'
  version '0.9.0'
  source_url 'https://github.com/ogham/exa/archive/v0.9.0.tar.gz'
  source_sha256 '96e743ffac0512a278de9ca3277183536ee8b691a46ff200ec27e28108fef783'

  depends_on 'cmake'
  depends_on 'rust'
  depends_on 'libgit2'

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
    system "install -Dm755 target/release/exa #{CREW_DEST_PREFIX}/bin/exa"
  end
end
