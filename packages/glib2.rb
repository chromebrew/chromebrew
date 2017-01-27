require 'package'

class Glib2 < Package
  version '2.0.7'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.0/glib-2.0.7.tar.gz'
  source_sha1 '02401937a5e06d8797d966b06d9a191425cbec6f'

  depends_on 'libffi'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
