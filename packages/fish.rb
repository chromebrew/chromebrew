require 'package'

class Fish < Package
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'http://fishshell.com/'
  version '2.5.0'
  source_url 'https://github.com/fish-shell/fish-shell/releases/download/2.5.0/fish-2.5.0.tar.gz'
  source_sha1 'ec52debe0a829b9df29f658697523af7c18ee778'

  depends_on 'ncurses'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
