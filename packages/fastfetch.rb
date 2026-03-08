# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.60.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6147efaf9c07b124d165e5bdb45a3b8a981a5cbb4af9e5c426b829b4f301b45',
     armv7l: 'f6147efaf9c07b124d165e5bdb45a3b8a981a5cbb4af9e5c426b829b4f301b45',
     x86_64: '382100770a54a57452e60aead6ac8d11dde98894d11b4dbf8775675afa122b3d'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable_only
  depends_on 'sqlite' => :build
  depends_on 'yyjson' => :executable_only

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
