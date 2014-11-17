require 'package'

class Zsh < Package
  version '5.0.7'
  source_url "http://softlayer-dal.dl.sourceforge.net/project/zsh/zsh/5.0.7/zsh-5.0.7.tar.gz"
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
