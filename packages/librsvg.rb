require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.61.3-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e742c76b9b716ec83c09362c01cffe6252ddb7bd66cd709a826f02fd20e5e234',
     armv7l: 'e742c76b9b716ec83c09362c01cffe6252ddb7bd66cd709a826f02fd20e5e234',
     x86_64: '5fffb5e72a497ba6af5a71a79182eb25bf7b0b600a609a5bf6a9072b248fb022'
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
