# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version "0.10.21-#{CREW_RUST_VER}"
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3237d2cf60838ea8f610d98b3a7ff4845beb6905760dfade72bba529a3fc6cc',
     armv7l: 'f3237d2cf60838ea8f610d98b3a7ff4845beb6905760dfade72bba529a3fc6cc',
       i686: '3bd2220487606febf676b6b50c4ea841eda3570b57316a6cdab628eb4e4b7dbf',
     x86_64: '8ec826659ecce5e0b7bcff5777cff4a4447090bcc9a594c5345ec0e52b7d52ef'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable
end
