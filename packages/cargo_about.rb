# Adapted from Arch Linux cargo-about PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cargo-about

require 'buildsystems/rust'

class Cargo_about < RUST
  description 'Cargo plugin to generate list of all licenses for a crate'
  homepage 'https://github.com/EmbarkStudios/cargo-about'
  version '0.8.4'
  license 'Apache MIT'
  compatibility 'all'
  source_url 'https://github.com/EmbarkStudios/cargo-about.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46f9e15a46d9ffbba523052af853b5c80b51aeb8fa6350aa56a2fde836ca8874',
     armv7l: '46f9e15a46d9ffbba523052af853b5c80b51aeb8fa6350aa56a2fde836ca8874',
       i686: 'a571d1a7721ee07663838d86041be348c27c88b3b2faf5686f4084e45cd13a68',
     x86_64: 'f2bfb1f67c896be2bfb43d1422b3a27ae8138a03f0a90b8fdb7042c42bd8cbce'
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
