require 'buildsystems/meson'

class Libproxy < Meson
  description 'libproxy is a library that provides automatic proxy configuration management.'
  homepage 'https://libproxy.github.io/libproxy/'
  version '0.5.11'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libproxy/libproxy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fb0d802aed10e6eecbee886f5cf401ab110a4be5b4e72047c4592490bc2c7a1',
     armv7l: '3fb0d802aed10e6eecbee886f5cf401ab110a4be5b4e72047c4592490bc2c7a1',
     x86_64: 'd8e41311996b9f2af4f1abd3d798e26ea33e90b51aac98f55655748a08149b57'
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
