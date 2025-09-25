require 'buildsystems/meson'

class Libadwaita < Meson
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.8.0-1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd026971c805574bbef1462f21ae78df8ecc9dcd54e4bc5ef7911436c82e7db70',
     armv7l: 'd026971c805574bbef1462f21ae78df8ecc9dcd54e4bc5ef7911436c82e7db70',
     x86_64: 'f3948cdfd7305a708d713550cc062b6a7f6f9c9d685f66d231376ac6b57c6299'
  })

  depends_on 'appstream' # R
  depends_on 'cairo' => :build
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libsass' => :build
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build

  gnome

  meson_options '-Dintrospection=enabled \
            -Dexamples=false \
            -Ddocumentation=false \
            -Dtests=false'
end
