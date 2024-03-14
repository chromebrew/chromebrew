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
    aarch64: '06cec6c34dc4656735a526af6d74d02452dd34de1654c46efd327a5c80932982',
     armv7l: '06cec6c34dc4656735a526af6d74d02452dd34de1654c46efd327a5c80932982',
     x86_64: 'decdaf546dac3ccee260617d756619892cd443f6b42c19b56318feae913cc31e'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'harfbuzz' # R
  depends_on 'js115' => :build
  depends_on 'libffi' # R
  depends_on 'libx11' # R

  meson_options '-Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dskip_gtk_tests=true \
    -Dprofiler=disabled \
    -Dreadline=disabled'
end
