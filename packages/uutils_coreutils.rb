# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.1.0-d1ec00f'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag 'd1ec00f8fa5ae61b3f1e8a550c50fedf49a47728'
  # git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91390670200ef027bd72e4aacfa760c9eb124ed488eaf299e87e9f6874113541',
     armv7l: '91390670200ef027bd72e4aacfa760c9eb124ed488eaf299e87e9f6874113541',
       i686: '371a1f44ebb35e3f1b0a8062fc0218ad21f2d6e71975ce2485ca68ef9f65cb92',
     x86_64: '5ecf1ad4d53a5479144cc4cd3c0aa638d20da94776e98f2cdcc4b2cc1ca443d0'
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
