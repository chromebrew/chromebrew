# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.13.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '479a54d90526d7e948990d8e77d4f754e60f810bc536653bc8707d87bbc5c689',
     armv7l: '479a54d90526d7e948990d8e77d4f754e60f810bc536653bc8707d87bbc5c689',
     x86_64: '861933f7f5d008ccf870591b1641601e0d506d381c6b5357bb89e004208bae3a'
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
