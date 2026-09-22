# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD
# NOTE: This package should be updated along with new Rust releases.

require 'buildsystems/rust'

class Cargo_c < RUST
  description 'A cargo subcommand to build and install C-ABI compatible dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version "0.10.25-#{CREW_RUST_VER}"
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88d0f1fe4373e9fa11c2ed9cadfdb3e0115343130e203b14e98e1e87d98557f7',
     armv7l: '88d0f1fe4373e9fa11c2ed9cadfdb3e0115343130e203b14e98e1e87d98557f7',
       i686: '0677da6b0344d239cba022b30a97c72f8c2407ae2ebe4b2225937bfe85810b6b',
     x86_64: '58b23f5118f0632af1a25fef94270c577901d6adb45f95b8d67b99a790d63073'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build
  depends_on 'zlib' => :executable
end
