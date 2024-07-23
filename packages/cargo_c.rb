# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD

require 'package'

class Cargo_c < Package
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version '0.9.13'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21825714180d7032b34e2c74582f4002d55dccc781bbbd3ba6bce1af88d1cade',
     armv7l: '21825714180d7032b34e2c74582f4002d55dccc781bbbd3ba6bce1af88d1cade',
       i686: 'f350e961fd5a16fb080adf24288e41559f037db3cab5b07f2ff74407d4370bac',
     x86_64: 'a45adb265c13605339cfc04548f3c33d13887307b20639abc7d4b385804768a0'
  })

  depends_on 'rust' => :build

  def self.build
    system "cargo fetch \
      --manifest-path Cargo.toml"
    system "cargo build \
      --release \
      --frozen \
      --manifest-path Cargo.toml"
  end

  def self.install
    system "cargo install \
      --frozen \
      --offline \
      --no-track \
      --path . \
      --root #{CREW_DEST_PREFIX}"
  end
end
