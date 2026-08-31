# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.11.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb4281097d363c3ac163a525fd40a9fcd7846cf7459268b5db6ad9358769515d',
     armv7l: 'fb4281097d363c3ac163a525fd40a9fcd7846cf7459268b5db6ad9358769515d',
     x86_64: '2a0d204872cd72d4255f24ca766a33b6d9836fa782b42e91f1ec5e254daec514'
  })

  depends_on 'acl' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
    # The following can also be done if necessary  from the shell via:
    # for i in $(coreutils --list) ; do /bin/ln -f /usr/local/bin/coreutils /usr/local/bin/$i ; done
    `#{CREW_DEST_PREFIX}/bin/coreutils --list`.chomp.split.each do |coreutil|
      Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
        FileUtils.link_entry 'coreutils', coreutil.to_s
      end
    end
  end
end
