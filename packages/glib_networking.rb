require 'buildsystems/meson'

class Glib_networking < Meson
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.78.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/glib-networking.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.78.0_armv7l/glib_networking-2.78.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.78.0_armv7l/glib_networking-2.78.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib_networking/2.78.0_x86_64/glib_networking-2.78.0-chromeos-x86_64.tar.zst'
  })
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
end
