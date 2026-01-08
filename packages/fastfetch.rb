# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.56.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a53400daace622eb3d0248cc82841976f1fa0c59aaa8e0c7ce9e30cd665bf1ce',
     armv7l: 'a53400daace622eb3d0248cc82841976f1fa0c59aaa8e0c7ce9e30cd665bf1ce',
     x86_64: '869df9d3a665d335af89fbf3ded81ecb2ca0d8088ca0199ce855236f6770193e'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'sqlite' => :build
  depends_on 'yyjson' # R

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
