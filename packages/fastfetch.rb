# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.42.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2c6084fd2dc22ea43e2aa9ca2745b8dee94349d02bedeb35bb7e7050ad5d58d',
     armv7l: 'e2c6084fd2dc22ea43e2aa9ca2745b8dee94349d02bedeb35bb7e7050ad5d58d',
     x86_64: '2b05cd0d4030300b5e110f63f1466c6ac4c4a0ba1bca6be46b48325051d5a118'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'sqlite' => :build
  depends_on 'yyjson' # R

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
