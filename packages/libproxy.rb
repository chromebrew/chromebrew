require 'buildsystems/meson'

class Libproxy < Meson
  description 'libproxy is a library that provides automatic proxy configuration management.'
  homepage 'https://libproxy.github.io/libproxy/'
  version '0.5.3'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libproxy/libproxy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2faef327daefacb96faecc16d2c732acdf77bbaa08b0815d733f3511d3575fea',
     armv7l: '2faef327daefacb96faecc16d2c732acdf77bbaa08b0815d733f3511d3575fea',
     x86_64: 'b5939b2138ba04d4014aeb4c98aa69739810f21a5459ac3383a474a8955fdda2'
  })

  depends_on 'curl' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'vala' => :build

  meson_options '-Ddocs=false \
              -Dpacrunner-duktape=false \
              -Dtests=false'
end
