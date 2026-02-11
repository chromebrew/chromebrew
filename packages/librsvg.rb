require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.61.91-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a406edc7d2d04fa28979458d281da79f9aa3979342cf0b3f95d12f3fe44d6668',
     armv7l: 'a406edc7d2d04fa28979458d281da79f9aa3979342cf0b3f95d12f3fe44d6668',
     x86_64: '470abf3fb4c0929a40272db9e2d48732001db8f3f6b887c442977e35554d1c3b'
  })

  depends_on 'cairo' # R
  depends_on 'cargo_c' => :build
  depends_on 'dav1d' # R
  depends_on 'fontconfig' => :executable_only
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

  meson_options '-Ddocs=disabled -Dintrospection=enabled -Dpixbuf-loader=enabled -Dtests=false -Dvala=enabled'
end
