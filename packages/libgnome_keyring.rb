require 'package'

class Libgnome_keyring < Package
  description 'GNOME keyring client library'
  homepage 'https://www.gnome.org'
  version '3.12.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libgnome-keyring/3.12/libgnome-keyring-3.12.0.tar.xz'
  source_sha256 'c4c178fbb05f72acc484d22ddb0568f7532c409b0a13e06513ff54b91e947783'

  depends_on 'dbus'
  depends_on 'libgcrypt'

  def self.build
      system "./configure #{CREW_OPTIONS} --enable-introspection=no --enable-vala=no"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
