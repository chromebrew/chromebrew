require 'buildsystems/meson'

class Glib_networking < Meson
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.78.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/glib-networking.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d2722140f2f0e71b7abac4acac2925ad798650f3307c2545a4cc4bfe21e599f',
     armv7l: '0d2722140f2f0e71b7abac4acac2925ad798650f3307c2545a4cc4bfe21e599f',
     x86_64: '7e778510957044f2fc5db7283cd171514983134a5bc1fe11337c77e7f5ffe108'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnutls' # R
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libproxy'

  gnome
end
