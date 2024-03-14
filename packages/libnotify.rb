require 'buildsystems/meson'

class Libnotify < Meson
  description 'A library for sending desktop notifications.'
  homepage 'https://git.gnome.org/browse/libnotify'
  version '0.8.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/GNOME/libnotify/archive/#{version}.tar.gz"
  source_sha256 '7c0b252edecbf08db50d775f9e720ecc03c742fb97c25f3966a8b7a4bedf8133'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bff49fc3b4241e28454b3b2de0a5fc0a63eeda9d7b33211e14e6edf1d4ee81e4',
     armv7l: 'bff49fc3b4241e28454b3b2de0a5fc0a63eeda9d7b33211e14e6edf1d4ee81e4',
     x86_64: '87df4130086c957b893d67dc6833efdb37d8b8c7470dc0e26c3f70657d2e37b4'
  })

  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R

  gnome

  meson_options '-Dman=false \
    -Ddocbook_docs=disabled \
    -Dtests=false \
    -Dgtk_doc=false'
end
