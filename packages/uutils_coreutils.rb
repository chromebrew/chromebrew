# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.7.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '745b6b22bd31606649088aa8c4ac5114f01553e8042cb52c93a1bd5b1cc3c669',
     armv7l: '745b6b22bd31606649088aa8c4ac5114f01553e8042cb52c93a1bd5b1cc3c669',
     x86_64: '30ed1d7c33c46c2da25805df842579fcf770996e8446b58e908d098db7cd9f82'
  })

  depends_on 'acl' => :build
  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'llvm_dev' => :build
  depends_on 'rust' => :build
  depends_on 'sphinx' => :build

  conflicts_ok # conflicts with coreutils, util_linux, zoneinfo

  rust_features 'unix uudoc'
  rust_release_profile 'release-small'

  rust_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    `#{CREW_DEST_PREFIX}/bin/uudoc --help`.partition('Available utilities:').last.gsub("\n    ", '').chomp.gsub(/\s+/, '').split(',').each do |utility|
      system "#{CREW_DEST_PREFIX}/bin/uudoc completion #{utility} bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/#{utility}"
      system "#{CREW_DEST_PREFIX}/bin/uudoc manpage #{utility} > #{CREW_DEST_PREFIX}/share/man/man1/#{utility}.1"
    end
    `#{CREW_DEST_PREFIX}/bin/coreutils --list`.chomp.split.each do |coreutil|
      Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
        FileUtils.ln_s 'coreutils', coreutil.to_s
      end
    end
  end
end
