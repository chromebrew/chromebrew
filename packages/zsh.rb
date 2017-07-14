require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.0.7'
  source_url 'http://sourceforge.net/projects/zsh/files/zsh/5.0.7/zsh-5.0.7.tar.gz/download'
  source_sha256 '43f0a4c179ef79bb8c9153575685f7f45f28a3615c8cf96345f503d5b9e7b919'

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
