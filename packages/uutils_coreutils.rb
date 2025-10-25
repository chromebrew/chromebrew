# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.3.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c2eb8878e039d8eefc6bab19789b2e424c1657901c49d5a796686b3788b4169',
     armv7l: '6c2eb8878e039d8eefc6bab19789b2e424c1657901c49d5a796686b3788b4169',
       i686: 'c0a793b94d20a9847b22f1b2077184f7bb104617c2b623aa648a89e191788d97',
     x86_64: 'a75ee4f389947838b4975aafb099e72473ef9bd0b9a350b781c87fe28733399f'
  })

  depends_on 'acl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build
  depends_on 'rust' => :build
  depends_on 'sphinx' => :build

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
