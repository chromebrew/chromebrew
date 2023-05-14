require 'package'

class Librsvg < Package
  description 'SVG library for GNOME'
  homepage 'https://wiki.gnome.org/Projects/LibRsvg'
  @_ver = '2.56.0'
  version @_ver
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/librsvg.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.56.0_armv7l/librsvg-2.56.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.56.0_armv7l/librsvg-2.56.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.56.0_i686/librsvg-2.56.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsvg/2.56.0_x86_64/librsvg-2.56.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f39f6e1529d64ee294a79a68cb2f8ff36a6d1704a3ba871bb1bbd253926aa283',
     armv7l: 'f39f6e1529d64ee294a79a68cb2f8ff36a6d1704a3ba871bb1bbd253926aa283',
       i686: 'b9abc50a6c9356c714ab16c9b7b146cbc3e461d87e1f0e7389cf75af160ef263',
     x86_64: '580d8fcd3430199122dbb222a8d399364d80b5dd96b9f786ab2d38f25decf570'
  })

  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' => :build
  depends_on 'gcc' # R
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
