# Adapted from Arch Linux cargo-about PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cargo-about

require 'buildsystems/rust'

class Cargo_about < RUST
  description 'Cargo plugin to generate list of all licenses for a crate'
  homepage 'https://github.com/EmbarkStudios/cargo-about'
  version '0.9.2'
  license 'Apache MIT'
  compatibility 'all'
  source_url 'https://github.com/EmbarkStudios/cargo-about.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '45e5070b43f50535d16bd3c16dc78d352b763e6cbc0fe1cc44de291c4431aa6e',
     armv7l: '45e5070b43f50535d16bd3c16dc78d352b763e6cbc0fe1cc44de291c4431aa6e',
       i686: 'bd44b38d9815f68f2bd8a2268d3b4bf3f033f64964f2add7380757760f7be94d',
     x86_64: '4d1483b1b0b2e7f73b8e2405fe8594a5a83333b1669e5a94c220a4cda39236d1'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

  rust_features 'cli'
  rust_install_extras do
    Dir.chdir("#{CREW_DEST_PREFIX}/bin") do
      FileUtils.ln_s 'cargo-about', 'about'
    end
  end
end
