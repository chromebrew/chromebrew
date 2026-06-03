require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.62.3-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d44e13730b0e1b572eb1fa44a2a31a69087540d07c591abdac3016dbca798c8',
     armv7l: '8d44e13730b0e1b572eb1fa44a2a31a69087540d07c591abdac3016dbca798c8',
     x86_64: '21d5b4268e8170e0d5c765975110d8386160a677a3b29073126b357a6cde5acc'
  })

  depends_on 'cairo' => :library
  depends_on 'cargo_c' => :build
  depends_on 'dav1d' => :library
  depends_on 'fontconfig' => :executable
  depends_on 'fribidi' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'harfbuzz' => :executable
  depends_on 'libcroco' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libxml2' => :library
  depends_on 'pango' => :library
  depends_on 'py3_meson' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'rust' => :build
  depends_on 'vala' => :build

  gnome

  ENV['CARGO_PROFILE_RELEASE_LTO'] = 'true'

  meson_options '-Ddocs=disabled -Dintrospection=enabled -Dpixbuf-loader=enabled -Dtests=false -Dvala=enabled'
end
