require 'package'

class Gtk2 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '2.24.33-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.33.tar.xz'
  source_sha256 'ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk2/2.24.33-1_armv7l/gtk2-2.24.33-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk2/2.24.33-1_armv7l/gtk2-2.24.33-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk2/2.24.33-1_i686/gtk2-2.24.33-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk2/2.24.33-1_x86_64/gtk2-2.24.33-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '973cb7478861aa2821870c07e1ab3570b3d66afd51b3b065e1fd7598d4a666a2',
     armv7l: '973cb7478861aa2821870c07e1ab3570b3d66afd51b3b065e1fd7598d4a666a2',
       i686: '425d69586e1f990a1ef2eac1ecbafee226183bc2266a65a7df5fc6eb3e14b803',
     x86_64: '0e39307d3bb40f03a24d676404a8d5359f61a6d4b1219ab0aa4fb35be0b5806a'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk_doc'
  depends_on 'harfbuzz'
  depends_on 'libjpeg'
  depends_on 'libx11'
  depends_on 'libxcomposite'
  depends_on 'libxcursor'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxinerama'
  depends_on 'libxrandr'
  depends_on 'libxrender'
  depends_on 'pango'
  depends_on 'shared_mime_info'
  depends_on 'py3_six' => :build

  def self.build
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto' \
      ./configure #{CREW_OPTIONS} --with-gdktarget=x11"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
