require 'package'

class Fish < Package
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'http://fishshell.com/'
  version '2.6.0'
  source_url 'https://github.com/fish-shell/fish-shell/releases/download/2.6.0/fish-2.6.0.tar.gz'
  source_sha256 '7ee5bbd671c73e5323778982109241685d58a836e52013e18ee5d9f2e638fdfb'

  depends_on 'ncurses'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
