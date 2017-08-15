require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.0-1'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2'
  source_sha256 '08bd0d1dd30ece3cb9905ccd48b82b2f81c861696377508021265177dc153a61'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/vim-8.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/vim-8.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/vim-8.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/vim-8.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '00b27877b9f8df26396f172dba2761b85c1aa3ffd9332c7df3de7d9578e2a993',
     armv7l: '00b27877b9f8df26396f172dba2761b85c1aa3ffd9332c7df3de7d9578e2a993',
       i686: '8eb41d4ef310e5fde6416f6e205806ba8615df9b38a84e0c3d1fa9362451bc6e',
     x86_64: 'dd869d3d0a499ea0a931a8370b72fc69b4a37b89b6d8e389861294d72b0290c1',
  })

  depends_on 'ncurses'
  # vim uses shared library of following languages, so need them isntalled at run-time
  depends_on 'perl'
  depends_on 'python27'
  depends_on 'ruby'

  def self.build
    system './configure --prefix=/usr/local --enable-gui=no --with-features=huge --without-x --disable-nls --enable-multibyte  --with-tlib=ncurses --enable-perlinterp --enable-pythoninterp  --enable-rubyinterp --with-ruby-command=/usr/local/bin/ruby --disable-selinux'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    puts "\nMake sure to put your .vim directory in a subdirectory of /usr/local so it has execute permissions"
    puts "You can then symlink to your home directory so vim can see it"
    puts "\tln -s /usr/local/vim ~/.vim"
    puts "\tln -s ~/.vim/vimrc ~/.vimrc\n\n"
  end
end
