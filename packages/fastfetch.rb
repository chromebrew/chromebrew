# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.71.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47288dfb5afeaae5ea8c84bf09fb8e28d8424dd834d113e94a0cbf4437794745',
     armv7l: '47288dfb5afeaae5ea8c84bf09fb8e28d8424dd834d113e94a0cbf4437794745',
     x86_64: '62530a8a90c8e01f38877e2e3c4dce3b65b3070e3c6c89c0e9fb53d23143931e'
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
