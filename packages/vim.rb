require 'package'

class Vim < Package
  version '7.4'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2'
  source_sha1 '601abf7cc2b5ab186f40d8790e542f86afca86b7'

  depends_on 'ncurses'
  depends_on 'perl'
  depends_on 'python27'
  depends_on 'ruby'

  def self.build
    system './configure --prefix=/usr/local --enable-gui=no --with-features=huge --without-x --disable-nls --with-tlib=ncurses --enable-perlinterp --enable-pythoninterp  --enable-rubyinterp --with-ruby-command=/usr/local/bin/ruby'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    puts "\nMake sure to put your .vim directory in a subdirectory of /usr/local so it has execute permissions"
    puts "You can then symlink to your home directory so vim can see it"
    puts "\tln -s /usr/local/vim ~/.vim"
    puts "\tln -s ~/.vim/vimrc ~/.vimrc\n\n"
    puts "\nMake sure to add 'set nocompatible' without the '' to .vimrc file"
    puts "if your vim is having weird behavior"
  end
end
