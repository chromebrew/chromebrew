require 'package'

class Fish < Package
  version '2.3.0'
  source_url 'https://github.com/fish-shell/fish-shell/releases/download/2.3.0/fish-2.3.0.tar.gz'
  source_sha1 'afc6e9ea4cbd1ade63e9af41280b1f08bff23bba'

  depends_on 'ncurses'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
