require 'buildsystems/meson'

class Cairomm_1_0 < Meson
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.14.5'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/cairo/cairomm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '476734904312bcf2ab5f68b6e01c21d9cec2ce8a193bb72460a5ff4b6963d2f6',
     armv7l: '476734904312bcf2ab5f68b6e01c21d9cec2ce8a193bb72460a5ff4b6963d2f6',
       i686: '012bc214aeabf2221851723ffff25cbe9d3cb325cb44d954e4ce5e63f961458a',
     x86_64: '55cce265874cfb769db0f0c7583d6aaef29eb4919431c10d8db4adaacf94b289'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsigcplusplus' # R
  depends_on 'libxrender' => :build
  depends_on 'libxxf86vm' => :build

  meson_options '-Dbuild-documentation=false \
    -Dbuild-examples=false \
    -Dbuild-tests=false'
end
