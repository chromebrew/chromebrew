# Adapted from Arch Linux uutils-coreutils PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/uutils-coreutils/trunk/PKGBUILD

require 'buildsystems/rust'

class Uutils_coreutils < RUST
  description 'Cross-platform Rust rewrite of the GNU coreutils'
  homepage 'https://github.com/uutils/coreutils'
  version '0.0.30-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/uutils/coreutils.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67d8d5dd2b62a8af7c08b408c0fe9abb97844d66c10f7cc1ad06e94142b83038',
     armv7l: '67d8d5dd2b62a8af7c08b408c0fe9abb97844d66c10f7cc1ad06e94142b83038',
       i686: '1d5aa5768760cbe8a188436c207480b9ad7ee755a55268a8683e2c45da6429b2',
     x86_64: 'b5ac08778f164685a9652ca1e94e07cbbc56db5bfd6f6994e4e6140ddc179577'
  })

  depends_on 'acl' => :build
  depends_on 'rust' => :build
  depends_on 'sphinx' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # conflicts with coreutils

  rust_options '--features unix'
  rust_release_profile 'release-fast'

  rust_install_extras do
    coreutils = `#{CREW_DEST_PREFIX}/bin/coreutils --list`.split

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    coreutils.each do |util|
      system "cargo run completion #{util} bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/uu_#{util}"
      system "cargo run manpage #{util} > #{CREW_DEST_PREFIX}/share/man/man1/uu_#{util}.1"
      Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
        FileUtils.ln_s 'coreutils', "uu_#{util}"
      end
    end
  end
end
