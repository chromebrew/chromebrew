require 'package'

class Fish < Package
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'http://fishshell.com/'
  version '2.7.1'
  source_url 'https://github.com/fish-shell/fish-shell/archive/2.7.1.tar.gz'
  source_sha256 'eb43ea2eb9accf76661c487dd530a5fd345fa40a3201bd22cef2c52be39fb474'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
