require 'buildsystems/autotools'

class Librsvg < Autotools
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.57.0'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59d527215f9325d2996a6118a688da958691daf5e5fdb861945d8737123ea26f',
     armv7l: '59d527215f9325d2996a6118a688da958691daf5e5fdb861945d8737123ea26f',
     x86_64: '8a044e13f8f92706851ac7fd6268116ca329c81ab340a4bcaff993560e5060e2'
  })

  depends_on 'cairo' # R
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
  depends_on 'libjpeg' => :build
  depends_on 'libpng' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'py3_six' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'rust' => :build
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  configure_options '--enable-introspection=yes \
      --enable-vala=yes \
      --enable-pixbuf-loader'

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
