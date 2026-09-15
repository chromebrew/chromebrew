require 'buildsystems/meson'

class Glib_networking < Meson
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.90.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/glib-networking.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df04e321832e92da90d29ca9e4432a4f02efdfd46c4a4934accd095f20bf620b',
     armv7l: 'df04e321832e92da90d29ca9e4432a4f02efdfd46c4a4934accd095f20bf620b',
     x86_64: '028cd698744c180602703bfa91e212dacdd1c6f828370a83d14948d4fe4db51a'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library
  depends_on 'gsettings_desktop_schemas' => :library
  depends_on 'libproxy' => :library
  depends_on 'openssl' => :library

  gnome

  meson_options '-Dopenssl=enabled'
end
