require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.0.7'
  source_url "http://sourceforge.net/projects/zsh/files/zsh/5.0.7/zsh-5.0.7.tar.gz/download"
  source_sha1 "a77519d3a6c251c69b1f4924cacdac17cc8e6a9d"

  depends_on "ncurses"

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
