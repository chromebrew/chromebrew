# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.66.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '610f5110a9b438c8f9718d7e1c2846252fe6d8851522cfdaeb0d8366e6ca71e4',
     armv7l: '610f5110a9b438c8f9718d7e1c2846252fe6d8851522cfdaeb0d8366e6ca71e4',
     x86_64: '64fc147735e5cc6e6bdf6101e8fca296b1bbbe2ff568a4598091d2e1f1016777'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'sqlite' => :build
  depends_on 'yyjson' => :executable

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
