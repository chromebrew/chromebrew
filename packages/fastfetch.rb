# Adapted from Arch Linux fastfetch PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fastfetch

require 'buildsystems/cmake'

class Fastfetch < CMake
  description 'Like Neofetch, but much faster because written in C'
  homepage 'https://github.com/fastfetch-cli/fastfetch'
  version '2.65.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/fastfetch-cli/fastfetch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f818106b27e816a105f0d98c7c6b819ef84c9a77b46a26dc73d9be207d540e8',
     armv7l: '1f818106b27e816a105f0d98c7c6b819ef84c9a77b46a26dc73d9be207d540e8',
     x86_64: 'b23ba3807f6ba7978695be348c936a4d31f9592d5574711a51e85de42c11b1bd'
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
