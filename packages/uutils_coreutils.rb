# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59d56b5e199e5f8c2f6d4004bbde81a7348d7162bd34a6bcbcd31bd7a7fba979',
     armv7l: '59d56b5e199e5f8c2f6d4004bbde81a7348d7162bd34a6bcbcd31bd7a7fba979',
       i686: '82b8e9f4f21ab33f03e35741f48431263b9195be466a01f3ce72321728ef5d11',
     x86_64: '41781a6b7b100b04cd4dc120ed96a072e9d00d0fe005f6cefc45092d141410b5'
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
      system "cargo run --profile=#{rust_release_profile} --features #{rust_features} completion #{util} bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/#{util}"
      system "cargo run --profile=#{rust_release_profile} --features #{rust_features} manpage #{util} > #{CREW_DEST_PREFIX}/share/man/man1/#{util}.1"
      Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
        FileUtils.ln_s 'coreutils', util.to_s
      end
    end
  end
end
