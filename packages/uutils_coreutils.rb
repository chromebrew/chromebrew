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
    aarch64: '468167bc33398704ac5dc4b83d13c3cbf53b0b602b8cb4f269f4e26db98ed65b',
     armv7l: '468167bc33398704ac5dc4b83d13c3cbf53b0b602b8cb4f269f4e26db98ed65b',
       i686: '7b11bde5389add0bc8b2636b2506de483ba77f77e37caf1185bdb7962ff34426',
     x86_64: 'bae2c8b8c85170172a89ec44edfd7def43494e985fdbb81dd146de63cd02c488'
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
