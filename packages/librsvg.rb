require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.60.0-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1c2cfe29ed9457bc56b965beacba6e539358b2b10181124a2a5b9f0e0492dd0',
     armv7l: 'f1c2cfe29ed9457bc56b965beacba6e539358b2b10181124a2a5b9f0e0492dd0',
     x86_64: '376db5e725f91f0f2e74e6c2cd542d8546eae631729116b680f7989c17320134'
  })

  depends_on 'cairo' # R
  depends_on 'cargo_c' => :build
  depends_on 'dav1d' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libcroco' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libpng' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'py3_meson' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'rust' => :build
  depends_on 'vala' => :build
  depends_on 'zlib' # R

  gnome

  ENV['CARGO_PROFILE_RELEASE_LTO'] = 'true'

  meson_options '-Ddocs=disabled -Dintrospection=disabled -Dtests=false -Dvala=enabled'
end
