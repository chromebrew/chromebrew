require 'buildsystems/meson'

class Libvdpau < Meson
  description 'VDPAU is the Video Decode and Presentation API for UNIX. It provides an interface to video decode acceleration and presentation hardware present in modern GPUs.'
  homepage 'https://www.freedesktop.org/wiki/Software/VDPAU/'
  version '1.4'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/1.4/libvdpau-1.4.tar.bz2'
  source_sha256 '4258824c5a4555ef31de0a7d82b3caf19e75a16a13949f1edafc5f6fb2d33f30'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73992847475a7d71f6b5a021d0f4e7aeee3477eb0fd75951019e78a01489f5e0',
     armv7l: '73992847475a7d71f6b5a021d0f4e7aeee3477eb0fd75951019e78a01489f5e0',
     x86_64: '5bec2dc65194041707e6c39e131d85639314b1cb40925d015309c7061fe046bc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'graphviz' => :build
  depends_on 'libx11' # R
  depends_on 'libxext' # R
end
