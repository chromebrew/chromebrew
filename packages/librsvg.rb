require 'buildsystems/meson'

class Librsvg < Meson
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version "2.59.2-#{CREW_ICU_VER}"
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '849b834e2d40a895894ca474876a96082c80178f535c96f2511a9e14c6c04fb8',
     armv7l: '849b834e2d40a895894ca474876a96082c80178f535c96f2511a9e14c6c04fb8',
     x86_64: '53c9762b60acf8558deced395176830befcf97976f5c8a6f697fa2e98babcc1c'
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

  meson_options '-Dintrospection=enabled -Dvala=enabled'

  def self.patch
    # As per https://gitlab.gnome.org/GNOME/librsvg/-/issues/1155#note_2356939
    # using the change that was merged into 2.59.90.
    downloader 'https://gitlab.gnome.org/GNOME/librsvg/-/merge_requests/1066.diff', '16b588b770066c983862a7b4e6cb5aa721f62a9b35b376ea8ea15a30dd2328c5'
    system 'patch -Np1 -i 1066.diff'
  end
end
