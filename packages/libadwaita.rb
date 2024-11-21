require 'buildsystems/meson'

class Libadwaita < Meson
  description 'Library of GNOME-specific UI patterns, replacing libhandy for GTK4'
  homepage 'https://gitlab.gnome.org/GNOME/libadwaita/'
  version '1.6.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libadwaita.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e878a076bd1b32ffac81c0c1a4a1507528933d805ec28ebccba93298bd6905c7',
     armv7l: 'e878a076bd1b32ffac81c0c1a4a1507528933d805ec28ebccba93298bd6905c7',
     x86_64: '5aa963f1ccdcaf5b515add4c4f4c0e0cecc409d119d5d0c823f4e498608d86e5'
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
  # Keep the gtk4 dependency from being pulled in during a gtk3 build.
  depends_on 'gtk4' unless ancestors[0].to_s.split('::')[1].downcase == 'gtk3' # R
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
