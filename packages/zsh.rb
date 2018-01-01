require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.4.2'
  source_url 'https://downloads.sourceforge.net/project/zsh/zsh/5.4.2/zsh-5.4.2.tar.xz'
  source_sha256 'a80b187b6b770f092ea1f53e89021d06c03d8bbe6a5e996bcca3267de14c5e52'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
