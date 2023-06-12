require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  version '2.56.0-59d5d83'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag '59d5d832be20c37f301ccf4d0de2e0004d49bd86'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.56.0-59d5d83_armv7l/librsvg-2.56.0-59d5d83-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.56.0-59d5d83_armv7l/librsvg-2.56.0-59d5d83-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.56.0-59d5d83_i686/librsvg-2.56.0-59d5d83-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.56.0-59d5d83_x86_64/librsvg-2.56.0-59d5d83-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fa8525eccd9577796f53fdb62118a004abdbb75d69bbf50c98abf37ab6598022',
     armv7l: 'fa8525eccd9577796f53fdb62118a004abdbb75d69bbf50c98abf37ab6598022',
       i686: '147942d68517190deaedfe3a69b6ff6e70c5f4aa7725d0aa6aa704d19dc98b23',
     x86_64: '7cf6e73193d51fe89715bcaffd7fa30eace1eda3ee94b7bff06f819035376bc5'
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

  gnome

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "mold -run ./configure \
      #{CREW_OPTIONS} \
      --enable-introspection=yes \
      --enable-vala=yes \
      --enable-pixbuf-loader"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
