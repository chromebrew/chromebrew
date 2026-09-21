require 'buildsystems/meson'

class Igt_gpu_tools < Meson
  description 'Tools for development and testing of the Intel DRM driver'
  homepage 'https://gitlab.freedesktop.org/drm/igt-gpu-tools'
  version '2.5'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://xorg.freedesktop.org/releases/individual/app/igt-gpu-tools-#{version}.tar.xz"
  source_sha256 'bf5ee5cc1e2b92c456d626b7986be9e2d18b4765cd06c28c1ab449200c1ce5e2'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '27d98727b0e7939b38b7967b0bc1ad3807f2bc57810d8c4c07146aa08a80dce2'
  })

  depends_on 'cairo' => :library
  depends_on 'elfutils' => :library
  depends_on 'eudev' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'libdrm' => :library
  depends_on 'libkmod' => :library
  depends_on 'libpciaccess' => :library
  depends_on 'libunwind' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'libxrandr' => :library
  depends_on 'libxv' => :library
  depends_on 'pciutils' => :library
  depends_on 'peg' => :library
  depends_on 'pixman' => :library
  depends_on 'procps' => :executable
  depends_on 'swig' => :build
  depends_on 'zlib' => :executable

  meson_options ' \
    -Ddocs=disabled \
    -Dtests=disabled \
    -Doping=disabled \
    -Drunner=disabled'
end
