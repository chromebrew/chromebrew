require 'buildsystems/meson'

class Gjs < Meson
  description 'Javascript Bindings for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/gjs/'
  version '1.79.90'
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ddcbf2cd059a44a886900bd364e569cb749ef5554f415be86c6d276b55a0e5b',
     armv7l: '4ddcbf2cd059a44a886900bd364e569cb749ef5554f415be86c6d276b55a0e5b',
     x86_64: 'fd47d6cbf0e9f4cbf41eae0cd5e3c4fa3a7336ea91636c1616947b1dfae825ea'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'harfbuzz' # R
  depends_on 'js115' # R
  depends_on 'libffi' # R
  depends_on 'libx11' # R

  gnome

  meson_options '-Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dskip_gtk_tests=true \
    -Dprofiler=disabled \
    -Dreadline=disabled'
end
