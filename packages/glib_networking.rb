require 'buildsystems/meson'

class Glib_networking < Meson
  description 'Network extensions for GLib'
  homepage 'https://github.com/GNOME/glib-networking'
  version '2.90.1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/glib-networking.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06c7fc9178ab79a9473f4f739c1f8f131a4133ed97730f4c54f7e04ca199bed2',
     armv7l: '06c7fc9178ab79a9473f4f739c1f8f131a4133ed97730f4c54f7e04ca199bed2',
     x86_64: '701a1764cd77ce1a00afc0eec0b529e4450c074f1363e7223a676c1cb4b9a885'
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
