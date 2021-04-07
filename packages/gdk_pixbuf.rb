require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.42.4'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.2.tar.xz'
  source_sha256 '83c66a1cfd591d7680c144d2922c5955d38b4db336d7cd3ee109f7bcf9afef15'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '23fc39d28ea5c1680730dcc387919446c41b57e341b8efcb8bdfa9c0662dddec',
     armv7l: '23fc39d28ea5c1680730dcc387919446c41b57e341b8efcb8bdfa9c0662dddec',
       i686: '259535541d24d83bc47503087eb0f84c50a29aa22e4eb61ab8ce33f465051bb5',
     x86_64: '5c4ccbdf7b580052fc9788bc0d5174061ea84028851c74ce7b258d6a17413517'
  })

  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'jasper' => :build
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp' => :build
  depends_on 'pango' => :build
  depends_on 'six' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Dinstalled_tests=false \
      -Dbuiltin_loaders=all \
      -Drelocatable=true \
      -Djasper=true \
      -Ddebug=false \
      -Dman=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    loader_dir = "#{CREW_DEST_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    FileUtils.mkdir_p loader_dir
    system "touch #{loader_dir}.cache"
  end

  def self.postinstall
    system 'env GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders \
      GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache \
      gdk-pixbuf-query-loaders --update-cache'
    gdk_pixbuf_in_bashrc = `grep -c "GDK_PIXBUF_MODULEDIR" ~/.bashrc || true`
    unless gdk_pixbuf_in_bashrc.to_i.positive?
      puts 'Putting GDK_PIXBUF code in ~/.bashrc'.lightblue
      system "echo 'export GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders' >> ~/.bashrc"
      system "echo 'export GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
  end
end
