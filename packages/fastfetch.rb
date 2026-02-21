# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.59.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4da9079902e215d73e79b5716f7a0fa0826ec0e1aeaa93a3a0d9fa43a7e372f',
     armv7l: 'c4da9079902e215d73e79b5716f7a0fa0826ec0e1aeaa93a3a0d9fa43a7e372f',
     x86_64: '763553c014ee786da7e73355a6150119f8ad80db49939e97f26d7b64591ae9bc'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :executable_only
  depends_on 'sqlite' => :build
  depends_on 'yyjson' => :executable_only

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
