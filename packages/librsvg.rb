require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.62.91-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef249d1f90ba3a2017d62543ac433f7438ce683d3a9bf8666e482a525ed312d0',
     armv7l: 'ef249d1f90ba3a2017d62543ac433f7438ce683d3a9bf8666e482a525ed312d0',
     x86_64: 'ffa8a192b9439d33ae61a1d89635a05aa53b42025482ebf7cd8837c62cec3a06'
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
