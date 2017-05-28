require 'package'

class Vim < Package
  version '8.0-1'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2'
  source_sha1 '54bb7fe631ed8eaea5675ec934e88b0da1f1eca0'

  depends_on 'ncurses'
  depends_on 'perl' => :build
  depends_on 'python27' => :build
  depends_on 'ruby' => :build

  def self.build
    system './configure --prefix=/usr/local --enable-gui=no --with-features=huge --without-x --disable-nls --enable-multibyte  --with-tlib=ncurses --enable-perlinterp --enable-pythoninterp  --enable-rubyinterp --with-ruby-command=/usr/local/bin/ruby --disable-selinux'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/vim"

    puts "\nMake sure to put your .vim directory in a subdirectory of /usr/local so it has execute permissions"
    puts "You can then symlink to your home directory so vim can see it"
    puts "\tln -s /usr/local/vim ~/.vim"
    puts "\tln -s ~/.vim/vimrc ~/.vimrc\n\n"
  end
end
