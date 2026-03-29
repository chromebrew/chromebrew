# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.61.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0c631698cadf2ab1ec53d964a0bcaee9fc9029dcab1da7e5497b7b02b1f4240',
     armv7l: 'e0c631698cadf2ab1ec53d964a0bcaee9fc9029dcab1da7e5497b7b02b1f4240',
     x86_64: '71a283635274d04335f6094b2964a39908aab6dff2635642c02aefc0638946e2'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
  depends_on 'sqlite' => :build
  depends_on 'yyjson' => :executable

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
