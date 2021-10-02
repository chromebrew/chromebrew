require 'package'

class Gtk2 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '2.24.33-2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.33.tar.xz'
  source_sha256 'ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk2/2.24.33-2_armv7l/gtk2-2.24.33-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk2/2.24.33-2_armv7l/gtk2-2.24.33-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk2/2.24.33-2_i686/gtk2-2.24.33-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk2/2.24.33-2_x86_64/gtk2-2.24.33-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '3e4c4c44a9713a5e37770718e7951062ea9b986bb1a9a99d45f4fd79a9fdf747',
     armv7l: '3e4c4c44a9713a5e37770718e7951062ea9b986bb1a9a99d45f4fd79a9fdf747',
       i686: 'aaa52bb7041e4d459314b8a27d1564a9aac73a6464c055ce78a6860bc169de0a',
     x86_64: 'c2696e86d1b93611ff3f0d6c5931cdb2666afb0f90324a25214db3e6c2a51df3',
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
    system "#{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} --with-gdktarget=x11"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.mv 'gtk-update-icon-cache', 'gtk2-update-icon-cache'
    end
  end

  def self.postinstall
    unless File.exists? "#{CREW_PREFIX}/bin/gtk-update-icon-cache"
      Dir.chdir "#{CREW_PREFIX}/bin" do
        FileUtils.ln_s 'gtk2-update-icon-cache', 'gtk-update-icon-cache'
      end
    end
  end

  def self.remove
    if File.symlink? "#{CREW_PREFIX}/bin/gtk-update-icon-cache"
      FileUtils.rm "#{CREW_PREFIX}/bin/gtk-update-icon-cache"
    end
  end
end
