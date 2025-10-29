require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.61.2-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29c37ea9e5d737b6770e141597180ded69a7d320535a3b96131215521a8e5321',
     armv7l: '29c37ea9e5d737b6770e141597180ded69a7d320535a3b96131215521a8e5321',
     x86_64: '51bea22d55325419632a3fc2aca03781be92919588ae3bd0d3c2acf1b4ce5bf5'
  })

  depends_on 'cairo' # R
  depends_on 'cargo_c' => :build
  depends_on 'dav1d' # R
  depends_on 'fribidi' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libcroco' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'py3_meson' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'rust' => :build
  depends_on 'vala' => :build

  gnome

  ENV['CARGO_PROFILE_RELEASE_LTO'] = 'true'

  meson_options '-Ddocs=disabled -Dintrospection=disabled -Dtests=false -Dvala=enabled'
end
