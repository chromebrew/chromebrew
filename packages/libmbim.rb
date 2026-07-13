require 'buildsystems/meson'

class Libmbim < Meson
  description 'libmbim is a glib-based library for talking to WWAN modems and devices which speak the Mobile Interface Broadband Model (MBIM) protocol.'
  homepage 'https://www.freedesktop.org/wiki/Software/libmbim/'
  version '1.34.0'
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mobile-broadband/libmbim.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19d452828b1fed44a46d364ba0bfc44decc42cc74b4bffefc67c2e8d2db55948',
     armv7l: '19d452828b1fed44a46d364ba0bfc44decc42cc74b4bffefc67c2e8d2db55948',
       i686: 'd0f8ee7188521556d72ba9f3d5d87c522f3aa102e8ebcfee95d04a37df3a0888',
     x86_64: '38a1025baa5b644e9a3296e073cc43e7593243a8fdaa220823504a152b537d22'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :library
end
