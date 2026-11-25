require 'buildsystems/meson'

class Wpebackend_fdo < Meson
  description 'Freedesktop.org backend for WPE WebKit'
  homepage 'https://wpewebkit.org'
  version '1.16.1'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url 'https://github.com/Igalia/WPEBackend-fdo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd36d966f2730f26fc9bb4c543a2075f1cdda82e596bd2a3d1b578d8fba615362',
     armv7l: 'd36d966f2730f26fc9bb4c543a2075f1cdda82e596bd2a3d1b578d8fba615362',
     x86_64: '44d3622decb426eac004f8e4d1a4c25366d4c2e076e523bebd606956cda2e9e9'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libepoxy' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libwpe' => :library
  depends_on 'mesa' => :build
  depends_on 'wayland' => :library
  depends_on 'wayland_protocols' => :build
end
