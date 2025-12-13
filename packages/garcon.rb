require 'buildsystems/meson'

class Garcon < Meson
  description 'Glib/GIO freedesktop.org compliant menu implementation'
  homepage 'https://docs.xfce.org/xfce/garcon/start'
  version '4.21.0'
  license 'LGPL-2 and Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.xfce.org/xfce/garcon.git'
  git_hashtag "garcon-#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'gtk3'
  depends_on 'libxfce4ui'

  meson_options '-Dintrospection=false'
end
