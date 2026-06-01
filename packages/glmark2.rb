# Adapted from Arch Linux glmark2 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=glmark2

require 'buildsystems/meson'

class Glmark2 < Meson
  description 'OpenGL ES 2.0 benchmark'
  homepage 'https://github.com/glmark2/glmark2'
  version '2023.01'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/glmark2/glmark2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6df352d5fbc555bbaa9c7b8e086bfb3f2dc9dfdb0b3a3779a55856b81bc1aaaa',
     armv7l: '6df352d5fbc555bbaa9c7b8e086bfb3f2dc9dfdb0b3a3779a55856b81bc1aaaa',
     x86_64: 'fa66ccadcf21ea75a81564e98ae7ec8df4bd56a77000c5067d6de753bc4a114e'
  })

  depends_on 'eudev' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libdrm' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'mesa' => :executable
  depends_on 'wayland' => :executable

  meson_options '-Dflavors=drm-gl,drm-glesv2,wayland-gl,wayland-glesv2,x11-gl,x11-glesv2'
end
