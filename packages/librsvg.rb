require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.62.1-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3308157ee7b14a2d042ea8b01f9fe8360d7ec42ef36146026a2996dc74b9a1f9',
     armv7l: '3308157ee7b14a2d042ea8b01f9fe8360d7ec42ef36146026a2996dc74b9a1f9',
     x86_64: '642dcd58a3efec27ae9f1fc4b1b5afc9c2828f669b298f1fdac3ae0d214bab47'
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
  depends_on 'gobject_introspection' => :build
  depends_on 'harfbuzz' => :executable
  depends_on 'harfbuzz' => :library
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
