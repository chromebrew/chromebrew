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
    aarch64: 'ce71b01c5f6ef8096a50fee9260b96e91d57474ae22d83ada5833a99a5719b79',
     armv7l: 'ce71b01c5f6ef8096a50fee9260b96e91d57474ae22d83ada5833a99a5719b79',
     x86_64: 'fd753c46109c33848dbe1faa8be740ecfcc7d2a0bb6fe87ba2b35b0622721120'
  })

  depends_on 'chafa' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'sqlite' => :build
  depends_on 'yyjson' # R

  cmake_options "-DENABLE_SYSTEM_YYJSON=ON \
    -DINSTALL_LICENSE=OFF"
end
