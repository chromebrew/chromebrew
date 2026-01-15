# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.57.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a790be49dbd3d9ede9afa8c720d7f8a4b16fba00a580eb59b8ca3afab0983ed',
     armv7l: '8a790be49dbd3d9ede9afa8c720d7f8a4b16fba00a580eb59b8ca3afab0983ed',
     x86_64: '8e8484133f089e037a47ee7fd6deccc3e79cb920583597736ad7dec27f76f978'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'sqlite' => :build
  depends_on 'yyjson' # R

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
