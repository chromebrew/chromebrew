# Adapted from Arch Linux cargo-about PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cargo-about

require 'buildsystems/rust'

class Cargo_about < RUST
  description 'Cargo plugin to generate list of all licenses for a crate'
  homepage 'https://github.com/EmbarkStudios/cargo-about'
  version '0.7.1'
  license 'Apache MIT'
  compatibility 'all'
  source_url 'https://github.com/EmbarkStudios/cargo-about.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c74f01d9c6327ffd3c7971a56447e7c83df5f14ed1e40a60452795747e3aadb',
     armv7l: '0c74f01d9c6327ffd3c7971a56447e7c83df5f14ed1e40a60452795747e3aadb',
       i686: '8038a9cfaf806775f03ab9bf02d8caab93758508be712caa82a0a171eeca2ae8',
     x86_64: '64646e7fca526ae51f654c15d85ab0156b2dfbdc33a9a5b77e4ccc1d639d4984'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build
  
  rust_install_extras do
    Dir.chdir("#{CREW_DEST_PREFIX}/bin") do
      FileUtils.ln_s 'cargo-about', 'about'
    end
  end
end
