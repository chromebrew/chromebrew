require 'buildsystems/meson'

class Garcon < Meson
  description 'Glib/GIO freedesktop.org compliant menu implementation'
  homepage 'https://docs.xfce.org/xfce/garcon/start'
  version '4.21.0'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.xfce.org/xfce/garcon.git'
  git_hashtag "garcon-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40f22a48aebdffed185a37ff1eeb2f89f629cf659973a63e6a4c867c0568aa92',
     armv7l: '40f22a48aebdffed185a37ff1eeb2f89f629cf659973a63e6a4c867c0568aa92',
     x86_64: '27e2370a3c6750f2cee3ac29a5f7465a25dc1c7f95dce677cca3642c0569a826'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'libxfce4ui' # R
  depends_on 'libxfce4util' # R

  meson_options '-Dintrospection=false'
end
