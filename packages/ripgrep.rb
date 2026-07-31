require 'package'

class Ripgrep < Package
  description 'ripgrep recursively searches directories for a regex pattern'
  homepage 'https://github.com/BurntSushi/ripgrep'
  version '15.2.0'
  license 'Apache-2.0, BSD-2, Boost-1.0 and MIT or Unlicense'
  compatibility 'all'
  source_url 'https://github.com/BurntSushi/ripgrep.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdff508de644154a18a1636ab681c6d9255d7551d19f2f35a92c42db04006ea0',
     armv7l: 'cdff508de644154a18a1636ab681c6d9255d7551d19f2f35a92c42db04006ea0',
       i686: 'bad92325e65b9950933b7e3ddfce7e3a6bbc2b91a10b2333251dd3b213d08c39',
     x86_64: 'd22b1ddd15dafa60399cabba67f30d29d526488411aa741dcdae48e2b63693cf'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

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
    FileUtils.install 'target/release/rg', "#{CREW_DEST_PREFIX}/bin/rg", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'rg' to get started.\n"
  end
end
