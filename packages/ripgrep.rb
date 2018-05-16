require 'package'

class Ripgrep < Package
  description 'ripgrep recursively searches directories for a regex pattern'
  homepage 'https://github.com/BurntSushi/ripgrep'
  version '0.8.1'
  source_url 'https://github.com/BurntSushi/ripgrep/archive/0.8.1.tar.gz'
  source_sha256 '7035379fce0c1e32552e8ee528b92c3d01b8d3935ea31d26c51a73287be74bb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ripgrep-0.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ripgrep-0.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ripgrep-0.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ripgrep-0.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7722213294547ddb9b404fc6af87744a8e3bca8418d104286ea537656d53453',
     armv7l: 'b7722213294547ddb9b404fc6af87744a8e3bca8418d104286ea537656d53453',
       i686: '772e4c4e1fa7352c813f2a032110ff4a54a311224b81e8003eaf407627ed81a9',
     x86_64: 'b1a981fa69a4622adb75167173afeed506b95ac685f8ea6dd82718b33547ef70',
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
