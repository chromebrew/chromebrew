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
    aarch64: 'd5929e8b0df2c1043728370afcf8bc33fcda134dec6f2fafa0d99d9f4bf36521',
     armv7l: 'd5929e8b0df2c1043728370afcf8bc33fcda134dec6f2fafa0d99d9f4bf36521',
     x86_64: 'a12939138f8ace49eaaa0188b39157f2e0619b17e67d4101411c7f3209a6a0a6'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsigcplusplus' # R
  depends_on 'libxrender' => :build
  depends_on 'libxxf86vm' => :build

  no_upstream_update

  meson_options '-Dbuild-documentation=false \
    -Dbuild-examples=false'
end
