require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.40.0-1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.40/gdk-pixbuf-2.40.0.tar.xz'
  source_sha256 '1582595099537ca8ff3b99c6804350b4c058bb8ad67411bbaae024ee7cead4e6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.40.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.40.0-1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.40.0-1-chromeos-x86_64.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.40.0-1-chromeos-i686.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1ee4c25a59579f11c12b3ef0f2b466710268164e4810c879861aa65a4185edfb',
     armv7l: '1ee4c25a59579f11c12b3ef0f2b466710268164e4810c879861aa65a4185edfb',
     x86_64: 'b8ab8af77ef2b41003487ea06f17ffa8e3828af62b646aa634b8a092160df1ea',
       i686: 'e041085afe17c2a853ef5057e44c05e3e3b0e4b943557f1d60e59b574ee52bf3',
  })

  depends_on 'meson' => :build
  depends_on 'pango'
  depends_on 'gobject_introspection'
  depends_on 'jasper'
  depends_on 'libtiff'
  depends_on 'libjpeg_turbo'
  depends_on 'six'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'meson',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--mandir=#{CREW_PREFIX}/share/man",
             '-Dinstalled_tests=false',
             '-Dbuildtype=release',
             '-Drelocatable=true',
             '-Djasper=true',
             '-Ddebug=false',
             '-Dman=false'
      system 'ninja'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "DESTDIR=#{CREW_DEST_DIR} ninja install"
    end
    loader_dir = "#{CREW_DEST_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    FileUtils.mkdir_p "#{loader_dir}"
    system "touch #{loader_dir}.cache"
  end

  def self.postinstall
    ENV['GDK_PIXBUF_MODULEDIR'] = "#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    ENV['GDK_PIXBUF_MODULE_FILE'] = ENV['GDK_PIXBUF_MODULEDIR'] + '.cache'
    system 'gdk-pixbuf-query-loaders --update-cache'
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export GDK_PIXBUF_MODULEDIR=".lightblue + ENV['GDK_PIXBUF_MODULEDIR'].lightblue + "' >> ~/.bashrc".lightblue
    puts "echo 'export GDK_PIXBUF_MODULE_FILE=".lightblue + ENV['GDK_PIXBUF_MODULE_FILE'].lightblue + "' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
