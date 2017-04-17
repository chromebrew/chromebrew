require 'package'

class Atk < Package
  version '2.24.0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/atk/2.24/atk-2.24.0.tar.xz'
  source_sha1 '499fa622ea7c12ba15bef1b270a95d14607e3b67'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
