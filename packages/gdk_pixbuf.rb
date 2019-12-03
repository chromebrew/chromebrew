require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.40.0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.40/gdk-pixbuf-2.40.0.tar.xz'
  source_sha256 '1582595099537ca8ff3b99c6804350b4c058bb8ad67411bbaae024ee7cead4e6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.40.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.40.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.40.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '27c5d0f1f700078e2e1ec3497332468b433d654921c429f1babafcdd5dce8dd4',
     armv7l: '27c5d0f1f700078e2e1ec3497332468b433d654921c429f1babafcdd5dce8dd4',
       i686: '0fe14285a8dba7328f45d719a7f4b57112a561a4daffca3631d7b49fcba0efc3',
     x86_64: '04f4f25490ad360d585b34ca81b47ebc25d1f072a4062199d5ba090d13e89bb4',
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
             "--prefix=#{CREW_DEST_PREFIX}",
             "--libdir=#{CREW_DEST_LIB_PREFIX}",
             "--mandir=#{CREW_DEST_PREFIX}/share/man",
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
      system 'ninja install'
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
