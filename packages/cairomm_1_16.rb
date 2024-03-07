require 'buildsystems/meson'

class Cairomm_1_16 < Meson
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.18.0'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/cairo/cairomm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91b832dbe79850875f8552e1f314eeaf78c01b4fa1371e9374a55001d0169ec9',
     armv7l: '91b832dbe79850875f8552e1f314eeaf78c01b4fa1371e9374a55001d0169ec9',
     x86_64: '73bc75296cdc4d6af8c005de02b4a843099c9758181111d7866cc0e701420085'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'libxrender' => :build
  depends_on 'libxxf86vm' => :build

  meson_options '-Dbuild-documentation=false \
    -Dbuild-examples=false'
end
