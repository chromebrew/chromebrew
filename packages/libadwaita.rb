require 'buildsystems/meson'

class Libadwaita < Meson
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.7.6'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0e0b175e7143f603c853093bb0418f211b3fdfd87ee7b2a2fd96bad1d3f527c',
     armv7l: 'b0e0b175e7143f603c853093bb0418f211b3fdfd87ee7b2a2fd96bad1d3f527c',
     x86_64: '9e7c5b55f927620903c2ec41557b7f183e9ad7285ad9be6df46c588842dc020a'
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

  # Keep the gtk4 dependency from being pulled in during a gtk3 build.

  gnome

  meson_options '-Dintrospection=enabled \
            -Dexamples=false \
            -Ddocumentation=false \
            -Dtests=false \
            -Dvapi=false'
end
