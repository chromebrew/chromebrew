require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  version '1.23.0'
  source_url 'https://raw.githubusercontent.com/rust-lang/rust/1.23.0/RELEASES.md'
  source_sha256 '05a4f35bad7643aea094066815cf856009b115170086bbd916cfb0ee9a31f54e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.23.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.23.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.23.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.23.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a68c57e384a5434fec9c210c015e6acd9e22eaac938ed6e1e8afd6e38d2675df',
     armv7l: 'a68c57e384a5434fec9c210c015e6acd9e22eaac938ed6e1e8afd6e38d2675df',
       i686: '932c881bdf3d726ae9d8782dfcabe42acbc3142edce6a08e558f0c2e4390d478',
     x86_64: 'f6c0ab056802e0d82a8e87664b8a3af8f536a2122e064596a795189bd73bed20',
  })

  def self.install
    if ARCH == 'armv7l'
      default_host = "armv7-unknown-linux-gnueabihf"
    else
      default_host = "#{ARCH}-unknown-linux-gnu"
    end
    system "curl -Ls https://sh.rustup.rs -o rust.sh"
    system "sed -i 's,\$(mktemp -d 2>/dev/null || ensure mktemp -d -t rustup),#{CREW_DEST_DIR},' rust.sh"
    system "bash rust.sh -y --no-modify-path --default-host #{default_host} --default-toolchain stable"
    system "mkdir -p #{CREW_DEST_DIR}/$HOME"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/cargo"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/rustup"
    system "cp -r ~/.cargo/. #{CREW_DEST_PREFIX}/share/cargo"
    system "cp -r ~/.rustup/. #{CREW_DEST_PREFIX}/share/rustup"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/cargo/bin") do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/cargo/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
    end
    system "rm -rf ~/.cargo ~/.rustup"
    system "ln -s #{CREW_PREFIX}/share/cargo $HOME/.cargo"
    system "ln -s #{CREW_PREFIX}/share/rustup $HOME/.rustup"
    system "ln -s #{CREW_PREFIX}/share/cargo #{CREW_DEST_DIR}/$HOME/.cargo"
    system "ln -s #{CREW_PREFIX}/share/rustup #{CREW_DEST_DIR}/$HOME/.rustup"
  end
end
