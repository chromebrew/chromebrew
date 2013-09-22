require 'package'

class Vim < Package
  version '7.4'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2'
  source_sha1 '601abf7cc2b5ab186f40d8790e542f86afca86b7'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/s6ya4cyeee7ywo9/vim-7.3-chromeos-i686.tar.gz?token_hash=AAEI_tXjoKfOGEWKN3fajxskcCxlOjxuANGIvu-nSABANQ&dl=1'
  })
  binary_sha1 ({
    i686: '5ff6cf19c34582027092d342fc835b0f32c63be0'
  })

  depends_on 'ncurses'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
