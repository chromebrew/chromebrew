require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  version '1.23.0'
  source_url 'https://raw.githubusercontent.com/rust-lang/rust/1.23.0/RELEASES.md'
  source_sha256 '05a4f35bad7643aea094066815cf856009b115170086bbd916cfb0ee9a31f54e'

  binary_url ({
  })
  binary_sha256 ({
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
