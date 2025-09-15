require 'buildsystems/meson'

class Libadwaita < Meson
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.8.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '179963b5724c6fbb1f78e6ee901de40340513d01b7b9f1f09eedcbe3c0f97b10',
     armv7l: '179963b5724c6fbb1f78e6ee901de40340513d01b7b9f1f09eedcbe3c0f97b10',
     x86_64: 'd7fff1f26efad67b47621d3fad890de83b86522fc58cf5c6e4f643635be14dae'
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
            -Dtests=false \
            -Dvapi=false'
end
