require 'buildsystems/autotools'

class Libgconf < Autotools
  description 'GConf is a system for storing application preferences.'
  homepage 'https://gitlab.gnome.org/Archive/gconf'
  version '3.2.6'
  license 'LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/GConf/3.2/GConf-3.2.6.tar.xz'
  source_sha256 '1912b91803ab09a5eed34d364bf09fe3a2a9c96751fde03a4e0cfa51a04d784c'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a6c6861a58365e66df3a2eb01faa1f801d52a34fbb10b2f1ac842f7e72affb6c',
     armv7l: 'a6c6861a58365e66df3a2eb01faa1f801d52a34fbb10b2f1ac842f7e72affb6c',
     x86_64: 'be97ae6807ad929e22b58e5ce3b561d0b0b49532b9980024aa854ffd762a1ec5'
  })

  depends_on 'dbus' # R
  depends_on 'dbus_glib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R

  gnome

  autotools_configure_options '--disable-orbit'
end
