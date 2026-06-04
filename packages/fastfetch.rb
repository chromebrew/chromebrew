# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.64.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e95bebd8f1403d93aa2b99d432141ab079b4534515838af7c0182bb0f1e9d91f',
     armv7l: 'e95bebd8f1403d93aa2b99d432141ab079b4534515838af7c0182bb0f1e9d91f',
     x86_64: '0b3a75500fefcbdaaa495bc31dcc1d29cac579a05c5c597ebd0aa730b0620e9a'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable
  depends_on 'sqlite' => :build
  depends_on 'yyjson' => :executable

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
