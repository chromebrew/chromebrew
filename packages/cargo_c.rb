# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version "0.10.26-#{CREW_RUST_VER}"
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd61d2371ebe742f69199b12f58ea4ab17ad7dc36cbcb99eb4d1bf545e935a94c',
     armv7l: 'd61d2371ebe742f69199b12f58ea4ab17ad7dc36cbcb99eb4d1bf545e935a94c',
       i686: '5634354d89ff426b3cae3b59c9d68ada742ccc8bc60a0326b686cf58d95b81d6',
     x86_64: '0bfccc78248102dbca630adac10395187aa5b21769beabc69f8b4d530ae38756'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable
end
