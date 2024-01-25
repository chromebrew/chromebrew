require 'package'

class Gtk2 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '2.24.33-3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.33.tar.xz'
  source_sha256 'ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3bbbe59aee297b198c45249a258ddac0f6a2216dee383bb9d699ceabc6983913',
     armv7l: '3bbbe59aee297b198c45249a258ddac0f6a2216dee383bb9d699ceabc6983913',
       i686: '2a53fc41ecf1ecbe083fc2be47ddf0396dc15f8b0d1e36f4a3b4d5891e98aabf',
     x86_64: '8bddd0719e044e3440c028bf86b16f60229d61c80dcfe29a2b88055fc1d0bbe0'
  })

  depends_on 'at_spi2_core'
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
  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'sommelier' unless ARCH == 'i686' # L

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
    unless File.exist? "#{CREW_PREFIX}/bin/gtk-update-icon-cache"
      Dir.chdir "#{CREW_PREFIX}/bin" do
        FileUtils.ln_s 'gtk2-update-icon-cache', 'gtk-update-icon-cache'
      end
    end
  end

  def self.remove
    FileUtils.rm "#{CREW_PREFIX}/bin/gtk-update-icon-cache" if File.symlink? "#{CREW_PREFIX}/bin/gtk-update-icon-cache"
  end
end
