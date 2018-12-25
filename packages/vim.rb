require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.1-1'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-8.1.tar.bz2'
  source_sha256 '8b69fbd01c877dd8ecbbeca1dc66e5e927228d631ac4c2174b9307eb5c827c86'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7dea736a534604b7356a2056097b13bb67804a9b7281ffae6d8462daa4596096',
     armv7l: '7dea736a534604b7356a2056097b13bb67804a9b7281ffae6d8462daa4596096',
       i686: '67422ff9eed379c72a8ce63ee214a5141aee420f187752838efc9c4ade8ffce9',
     x86_64: '6ebd581a5d978985b1eb8c5fe12fafb8e659e94a311a46a047f0eab2d6e4251b',
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
    system "touch #{configdir}/vimrc #{configdestdir}/vimrc"
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
