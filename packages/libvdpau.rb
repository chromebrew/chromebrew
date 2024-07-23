require 'buildsystems/meson'

class Libvdpau < Meson
  description 'VDPAU is the Video Decode and Presentation API for UNIX. It provides an interface to video decode acceleration and presentation hardware present in modern GPUs.'
  homepage 'https://www.freedesktop.org/wiki/Software/VDPAU/'
  version '1.5'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/vdpau/libvdpau.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54be014d64a3d0151dd9c77fba9bee49a1e8e6d46b39d25e3bba20abccc70fb3',
     armv7l: '54be014d64a3d0151dd9c77fba9bee49a1e8e6d46b39d25e3bba20abccc70fb3',
     x86_64: '7ea9f5cb75ca6a3511ff5da6ead6bd15e1cafb9d991d21000a76f5d06367a02d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'graphviz' => :build
  depends_on 'libx11' # R
  depends_on 'libxext' # R
end
