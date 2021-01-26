require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.42.2'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.2.tar.xz'
  source_sha256 '83c66a1cfd591d7680c144d2922c5955d38b4db336d7cd3ee109f7bcf9afef15'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '3db50fb39c83c5b61f4e27efbfedeaa0ea2706f7ef1f059e32d0f06ab712c93f',
      armv7l: '3db50fb39c83c5b61f4e27efbfedeaa0ea2706f7ef1f059e32d0f06ab712c93f',
        i686: '487395d7623101d17960ba51739e535a82f7362388c49bacc87449a56d7c3fe2',
      x86_64: '39f8ce2eb21d95bad9c5dbc68424374d94013d60681e03d4943d86d27c713e02',
  })

  depends_on 'pango'
  depends_on 'gobject_introspection'
  depends_on 'jasper'
  depends_on 'libtiff'
  depends_on 'libjpeg_turbo'
  depends_on 'libwebp'
  depends_on 'six'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Dinstalled_tests=false \
      -Dbuiltin_loaders=all \
      -Drelocatable=true \
      -Djasper=true \
      -Ddebug=false \
      -Dman=false \
      builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    loader_dir = "#{CREW_DEST_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    FileUtils.mkdir_p loader_dir
    system "touch #{loader_dir}.cache"
  end

  def self.postinstall
    ENV['GDK_PIXBUF_MODULEDIR'] = "#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    ENV['GDK_PIXBUF_MODULE_FILE'] = ENV['GDK_PIXBUF_MODULEDIR'] + '.cache'
    system 'gdk-pixbuf-query-loaders --update-cache'
    gdk_pixbuf_in_bashrc = `grep -c "GDK_PIXBUF_MODULEDIR" ~/.bashrc || true`
    unless gdk_pixbuf_in_bashrc.to_i > 0
      puts "Putting GDK_PIXBUF code in ~/.bashrc".lightblue
      system "echo 'export GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders' >> ~/.bashrc"
      system "echo 'export GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache' >> ~/.bashrc"
      puts "To complete the installation, execute the following:".orange
      puts "source ~/.bashrc".orange
    end
  end
end
