require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.0.586'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-8.0.586.tar.bz2'
  source_sha256 '08bd0d1dd30ece3cb9905ccd48b82b2f81c861696377508021265177dc153a61'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.0.586-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.0.586-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.0.586-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.0.586-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4b344479de2a777293f738d17944712ddc64339fedc1921cc72e4fd88494e780',
     armv7l: '4b344479de2a777293f738d17944712ddc64339fedc1921cc72e4fd88494e780',
       i686: '50dd8e043a2b264a7d468f186dbeda79520e763b4fab78ff577102e4962cb46d',
     x86_64: 'bd5abac6c9afe34430b95e983a240576474421af698491e046c9dd4cab7a511b',
  })

  depends_on 'compressdoc' => :build
  depends_on 'ncurses'
  # vim uses shared library of following languages, so need them isntalled at run-time
  depends_on 'perl'
  depends_on 'python27'
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
            --enable-pythoninterp \
            --enable-rubyinterp \
            --with-ruby-command=#{CREW_PREFIX}/bin/ruby \
            --disable-selinux"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end

  def self.postinstall
    puts "\nMake sure to put your .vim directory in a subdirectory of #{CREW_PREFIX} so it has execute permissions.".lightblue
    puts "You can then symlink to your home directory so vim can see it as follows:".lightblue
    puts "ln -s #{CREW_PREFIX}/vim ~/.vim".lightblue
    puts "ln -s ~/.vim/vimrc ~/.vimrc\n".lightblue
  end
end
