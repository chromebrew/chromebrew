require 'buildsystems/meson'

class Libadwaita < Meson
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.6.beta'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '986ab05714ec676db239846ec08a81ba6a7f6696b6726478b04655435ae3908b',
     armv7l: '986ab05714ec676db239846ec08a81ba6a7f6696b6726478b04655435ae3908b',
     x86_64: '9843c177eefacd1e5eb9bf08e7323d9131c243285bc31a01776664c52de8d2f7'
  })

  depends_on 'appstream' # R
  depends_on 'cairo' => :build
  depends_on 'curl' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libsass' => :build
  depends_on 'libxml2' # R
  depends_on 'libyaml' # R
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'xzutils' # R
  depends_on 'zstd' # R

  gnome

  meson_options '-Dintrospection=enabled \
            -Dexamples=false \
            -Dgtk_doc=false \
            -Dtests=false'
end
