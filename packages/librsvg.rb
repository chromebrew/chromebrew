require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.62.90-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '296e4aa8184e87a8264c8f42d09a66b6e499de65848cc5cd9e7b5a56e9752f4b',
     armv7l: '296e4aa8184e87a8264c8f42d09a66b6e499de65848cc5cd9e7b5a56e9752f4b',
     x86_64: '9440847bb70a70516b9eb4f53785e0eb611c2e9a3b166dc71fc60cc30766b55b'
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
