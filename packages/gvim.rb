require 'package'

class Gvim < Package
  description 'gVim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.1-1'
  source_url 'ftp://ftp.vim.org/pub/vim/unix/vim-8.1.tar.bz2'
  source_sha256 '8b69fbd01c877dd8ecbbeca1dc66e5e927228d631ac4c2174b9307eb5c827c86'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fdda85b0be941d9043acf35f166b7c95457ab96d04c8a3c82b96c7bc6314f99e',
     armv7l: 'fdda85b0be941d9043acf35f166b7c95457ab96d04c8a3c82b96c7bc6314f99e',
       i686: 'dcf0668bbabdd5623ed6481c3e1503a52df398771fe3c9fa64a1f58d1cb0ed95',
     x86_64: 'd8fb8c1ee73295d0e7646235c012f1785c38a67c46db18846faf33b89384cdfc',
  })

  depends_on 'vim'
  depends_on 'gtk2'
  depends_on 'sommelier'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --disable-nls \
            --enable-gui \
            --with-x \
            --enable-fontset \
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
    tmpdir = "#{CREW_PREFIX}/tmp/vim"
    configdir = "#{CREW_PREFIX}/.config/vim"
    configdestdir = "#{CREW_DEST_PREFIX}/.config/vim"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mkdir_p "#{tmpdir}"
    system "cp #{CREW_DEST_PREFIX}/bin/evi* #{tmpdir}"
    system "cp #{CREW_DEST_PREFIX}/bin/*gvi* #{tmpdir}"
    system "cp #{CREW_DEST_PREFIX}/share/man/man1/evi*.1 #{tmpdir}"
    system "cp #{CREW_DEST_PREFIX}/share/man/man1/*gvi*.1 #{tmpdir}"
    system "cp #{CREW_DEST_PREFIX}/share/vim/vim81/gvimrc_example.vim #{tmpdir}"
    system "rm -rf #{CREW_DEST_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/vim/vim81"
    system "mv #{tmpdir}/gvimrc_example.vim #{CREW_DEST_PREFIX}/share/vim/vim81"
    system "mv #{tmpdir}/*.1 #{CREW_DEST_PREFIX}/share/man/man1"
    system "mv #{tmpdir}/* #{CREW_DEST_PREFIX}/bin"
    system "rm -rf #{tmpdir}"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    FileUtils.mkdir_p "#{configdestdir}"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    system "touch #{configdir}/gvimrc #{configdestdir}/gvimrc"
    system "ln -s #{configdir}/gvimrc #{CREW_DEST_HOME}/.gvimrc"
  end

  def self.postinstall
    configdir = "#{CREW_PREFIX}/.config/vim"
    system "cp #{CREW_PREFIX}/share/vim/vim81/gvimrc_example.vim #{configdir}/gvimrc" unless File.size? "#{configdir}/gvimrc"
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo '# Fixes Warning: Missing charsets in String to FontSet conversion' >> ~/.bashrc".lightblue
    puts "echo 'export LC_ALL=C' >> ~/.bashrc && . ~/.bashrc".lightblue
    puts
    puts "The config files are located in $HOME/.vim".lightblue
    puts
  end
end
