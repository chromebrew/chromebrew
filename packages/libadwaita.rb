require 'buildsystems/meson'

class Libadwaita < Meson
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.5.rc'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74a70b4053156df9bad67c998a482d005c27ffcd9ee20a50a137727cb5f42c0c',
     armv7l: '74a70b4053156df9bad67c998a482d005c27ffcd9ee20a50a137727cb5f42c0c',
     x86_64: 'c0a183f3d4afbbd3c8d53e117b7db6537b384576f83e91beea45975290dfed44'
  })

  depends_on 'cairo' => :build
  depends_on 'fribidi' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glibc' => :build
  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'graphene' => :build
  depends_on 'gtk4' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'libjpeg' => :build
  depends_on 'libsass' => :build
  depends_on 'pango' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'curl' # R
  depends_on 'fribidi' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'libxml2' # R
  depends_on 'libyaml' # R
  depends_on 'pango' # R
  depends_on 'xzutils' # R
  depends_on 'zstd' # R

  gnome

  meson_options '-Dintrospection=enabled \
            -Dexamples=false \
            -Dgtk_doc=false \
            -Dtests=false'
end
