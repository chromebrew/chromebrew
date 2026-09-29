require 'buildsystems/meson'

class Igt_gpu_tools < Meson
  description 'Tools for development and testing of the Intel DRM driver'
  homepage 'https://gitlab.freedesktop.org/drm/igt-gpu-tools'
  version '2.6'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://xorg.freedesktop.org/releases/individual/app/igt-gpu-tools-#{version}.tar.xz"
  source_sha256 '5d5190debfec0ee1728430897f243d0afa271856c2cb5834a23b23f08be8d06e'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '86289e6c39e46ddd108dbeafc9735078aea1f11b2d4cc045b18af033e02a0f7c'
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
  depends_on 'libx11' => :executable
  depends_on 'libx11' => :library
  depends_on 'libxext' => :executable
  depends_on 'libxext' => :library
  depends_on 'libxrandr' => :library
  depends_on 'libxv' => :executable
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
