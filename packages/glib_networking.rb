require 'buildsystems/meson'

class Glib_networking < Meson
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.80.1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/glib-networking.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19a8a8ef2fa06b7d45c51bba0c22331116ef7bf93b4d3f2eb7d3714777ac43f6',
     armv7l: '19a8a8ef2fa06b7d45c51bba0c22331116ef7bf93b4d3f2eb7d3714777ac43f6',
     x86_64: 'deda8e0a46081719fa7b9eced02aebb4058c945251e4e8f4fef89b501d35a6bb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libproxy'

  gnome
end
