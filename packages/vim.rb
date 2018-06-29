require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.0-3'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2'
  source_sha256 '08bd0d1dd30ece3cb9905ccd48b82b2f81c861696377508021265177dc153a61'

  depends_on 'compressdoc' => :build
  depends_on 'ncurses'
  # vim uses shared library of following languages, so need them isntalled at run-time
  depends_on 'perl'
  depends_on 'python3'
  depends_on 'ruby'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --enable-gui=no \
            --with-features=huge \
            --without-x \
            --disable-nls \
            --enable-multibyte \
            --with-tlib=ncurses \
            --enable-perlinterp \
            --enable-python3interp \
            --enable-rubyinterp \
            --with-ruby-command=#{CREW_PREFIX}/bin/ruby \
            --with-vimdiff \
            --disable-selinux"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    system "cp #{CREW_DEST_PREFIX}/share/vim/vim80/vimrc_example.vim #{CREW_DEST_PREFIX}/share/vim/vim80/vimrc"
  end

  def self.postinstall
    puts "\nMake sure to put your .vim directory in a subdirectory of #{CREW_PREFIX} so it has execute permissions.".lightblue
    puts "You can then symlink to your home directory so vim can see it as follows:".lightblue
    puts "ln -s #{CREW_PREFIX}/share/vim/vim80 ~/.vim".lightblue
    puts "ln -s ~/.vim/vimrc ~/.vimrc\n".lightblue
  end
end
