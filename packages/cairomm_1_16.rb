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
    aarch64: 'f762614a3a14af45a249fb9c218864f90fc5f17c76e162b1ebac72a3f50ff8d6',
     armv7l: 'f762614a3a14af45a249fb9c218864f90fc5f17c76e162b1ebac72a3f50ff8d6',
       i686: '69c11234edaa48db3e9f916a66566eea806f451c48d787174a015c9d905607d3',
     x86_64: '98b889a6b0e94f60e931471faead51a176f1efd88bf17221c04ac1a13b2f195e'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'libxrender' => :build
  depends_on 'libxxf86vm' => :build

  meson_options '-Dbuild-documentation=false \
    -Dbuild-examples=false \
    -Dbuild-tests=false'
end
