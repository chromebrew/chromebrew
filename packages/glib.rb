require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib/'
  version '2.40.2-1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.40/glib-2.40.2.tar.xz'
  source_sha256 'e8ff8af2950897e805408480c454c415d1eade4e670ec5fb507f5e5853726c7a'

  depends_on 'libffi'
  depends_on 'gettext'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.cd("#{CREW_DEST_DIR}#{CREW_PREFIX}/include") do
      system "cp -r glib-2.0/* ."
      system "cp #{CREW_DEST_DIR}#{CREW_PREFIX}/lib/glib-2.0/include/glibconfig.h ."
      system "rm -rf #{CREW_DEST_DIR}#{CREW_PREFIX}/lib/glib-2.0/"
      system "rm -rf #{CREW_DEST_DIR}#{CREW_PREFIX}/lib/gio/"
      system "rm -rf glib-2.0/"
    end
  end
end
