# Adapted from Arch Linux cargo-about PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cargo-about

require 'buildsystems/rust'

class Cargo_about < RUST
  description 'Cargo plugin to generate list of all licenses for a crate'
  homepage 'https://github.com/EmbarkStudios/cargo-about'
  version '0.9.3'
  license 'Apache MIT'
  compatibility 'all'
  source_url 'https://github.com/EmbarkStudios/cargo-about.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef212d2f8a0d71ce8188ea03334518bd0246df309524f9e77d3a98b65698621d',
     armv7l: 'ef212d2f8a0d71ce8188ea03334518bd0246df309524f9e77d3a98b65698621d',
       i686: '808fb1fafbf2e9da33a2fa55e5991bfa6cb50594d80676ef360c08a23228f880',
     x86_64: '882dba75502f5bf184f44208357b15c0a2632d05b77b49d8339fa3ad9f00d280'
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
