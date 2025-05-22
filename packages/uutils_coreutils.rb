# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.30-0fd6e88'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  # git_hashtag version.split('-').first
  git_hashtag '0fd6e8894f4fb1c2d8d29b6126da4a5cf8e8e918'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f82af5600bd0a9486a5397e32ba66d3af5c180289d556a748daab19ae571b67',
     armv7l: '6f82af5600bd0a9486a5397e32ba66d3af5c180289d556a748daab19ae571b67',
       i686: '781b1d315e61440f6749c98791348d53b615757a0e475c666cebdb0211d1e393',
     x86_64: 'ef42470dc82e309a28cc7c86edc1896a5cfcd9305bea211bb1833f4996c746cc'
  })

  depends_on 'acl' => :build
  depends_on 'llvm_dev' => :build
  depends_on 'rust' => :build
  depends_on 'sphinx' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with coreutils

  rust_features 'unix'
  rust_release_profile 'release-fast'

  rust_install_extras do
    coreutils = `#{CREW_DEST_PREFIX}/bin/coreutils --list`.split

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    coreutils.each do |util|
      system "cargo run completion #{util} bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/#{util}"
      system "cargo run manpage #{util} > #{CREW_DEST_PREFIX}/share/man/man1/#{util}.1"
      Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
        FileUtils.ln_s 'coreutils', util.to_s
      end
    end
  end
end
