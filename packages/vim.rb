require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.1'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-8.1.tar.bz2'
  source_sha256 '8b69fbd01c877dd8ecbbeca1dc66e5e927228d631ac4c2174b9307eb5c827c86'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b8a982519a4f0b01410e42a5bb5ed915fca1847d10aca1d17cd7c85c9ef1f8d8',
     armv7l: 'b8a982519a4f0b01410e42a5bb5ed915fca1847d10aca1d17cd7c85c9ef1f8d8',
       i686: '18fa5898517801da4307f60e4e8ed1e74cd6ee46820f49a8c2cac0ee0458e1c9',
     x86_64: '89c090299914ffe373e3d25f42be5e85b888696da4bdb0d21256157cc00cf9ee',
  })

  depends_on 'python3'
  depends_on 'xdg_base'

  def self.preinstall
    configdir = "#{CREW_PREFIX}/.config"
    # Save any previous configuration, if it exists.
    if Dir.exists? "$HOME/.vim"
      system "cp -r $HOME/.vim #{configdir}"
      system "mv #{configdir}/.vim #{configdir}/vim"
      system "rm -rf $HOME/.vim"
    end
    if File.exists? "$HOME/.vimrc"
      system "cp $HOME/.vimrc #{configdir}/vim/vimrc"
    end
  end

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --enable-gui=no \
            --without-x \
            --disable-nls \
            --enable-multibyte \
            --with-tlib=ncurses \
            --enable-perlinterp \
            --enable-python3interp \
            --enable-rubyinterp \
            --with-python3-command=#{CREW_PREFIX}/bin/python3 \
            --with-ruby-command=#{CREW_PREFIX}/bin/ruby \
            --with-features=huge \
            --disable-selinux"
    system 'make'
  end

  def self.install
    configdir = "#{CREW_PREFIX}/.config/vim"
    configdestdir = "#{CREW_DEST_PREFIX}/.config/vim"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    FileUtils.mkdir_p "#{configdestdir}"
    system "cp -r #{CREW_DEST_PREFIX}/share/vim/vim81/* #{configdestdir}"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{configdir}" unless Dir.exists? "#{configdir}"
    system "ln -s #{configdir} #{CREW_DEST_HOME}/.vim"
    system "ln -s #{configdir}/vimrc #{CREW_DEST_HOME}/.vimrc"
    system "ln -sf #{configdir} $HOME/.vim"
    system "touch #{configdir}/vimrc #{configdestdir}/vimrc"
    system "ln -sf #{configdir}/vimrc $HOME/.vimrc"
  end

  def self.postinstall
    configdir = "#{CREW_PREFIX}/.config/vim"
    system "cp #{CREW_PREFIX}/share/vim/vim81/vimrc_example.vim #{configdir}/vimrc" unless File.size? "#{configdir}/vimrc"
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export VIMRUNTIME=$HOME/.vim' >> ~/.bashrc && . ~/.bashrc".lightblue
    puts
    puts "The config files are located in $HOME/.vim".lightblue
    puts
  end
end
