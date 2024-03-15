require 'buildsystems/meson'

class Libadwaita < Meson
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.5.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b3faec205030705a0c057d3acf659f381d8ca350a0742c197e26d8b5f35e57f',
     armv7l: '9b3faec205030705a0c057d3acf659f381d8ca350a0742c197e26d8b5f35e57f',
     x86_64: '8016af17106412697616c1af4159be10c66ff0b4d15bc303048bbc4f3a1885eb'
  })

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
  depends_on 'libjpeg' => :build
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
