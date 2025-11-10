require 'buildsystems/meson'

class Gjs < Meson
  description 'Javascript Bindings for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/gjs/'
  version '1.86.0'
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb53897926520377b10ef2d3483c4ca2c103f780a54fb514a8cbd87017747341',
     armv7l: 'eb53897926520377b10ef2d3483c4ca2c103f780a54fb514a8cbd87017747341',
     x86_64: 'e6311b3433b322b9b616b5f58224d9f6c9d0ff95e254574d1c69d357cb285c4f'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' => :build
  depends_on 'harfbuzz' # R
  depends_on 'js140' # R
  depends_on 'libffi' # R
  depends_on 'libx11' # R

  gnome

  meson_options '-Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dskip_gtk_tests=true \
    -Dprofiler=disabled \
    -Dreadline=disabled'
end
