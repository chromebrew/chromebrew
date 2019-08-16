require 'package'

class Gvim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'http://www.vim.org/'
  version '8.1.1852'
  source_url 'https://github.com/vim/vim/archive/v8.1.1852.tar.gz'
  source_sha256 'd543a06a075596e10d1ab4964b6a312ac78c7ccd0628d8b1d6b5deeb7b1d252e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1.1852-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1.1852-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1.1852-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1.1852-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '190f5cb34a24dc0d84247da66a45136102ac72be74067fce56a2cc9ff9e85fa2',
     armv7l: '190f5cb34a24dc0d84247da66a45136102ac72be74067fce56a2cc9ff9e85fa2',
       i686: '2c7926ad0e3e22d53cdd86822577c1d237617b0dda4e4bbbb61980e0e0c8fbf9',
     x86_64: '7dde5c7afe9b281a787599132f16033efafd67c2c41bea3d3823fb1558e121ae',
  })

  depends_on 'python27' => :build
  depends_on 'python3' => :build
  depends_on 'vim_runtime'
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.patch
    # set the system-wide vimrc path
    FileUtils.cd('src') do
      system "sed", "-i", "s|^.*#define SYS_VIMRC_FILE.*$|#define SYS_VIMRC_FILE \"#{CREW_PREFIX}/etc/vimrc\"|", "feature.h"
      system "sed", "-i", "s|^.*#define SYS_GVIMRC_FILE.*$|#define SYS_GVIMRC_FILE \"#{CREW_PREFIX}/etc/gvimrc\"|", "feature.h"
      system "autoconf"
    end
  end

  def self.build
    system "./configure",
              "--prefix=#{CREW_PREFIX}",
              "--localstatedir=#{CREW_PREFIX}/var/lib/vim",
              "--with-features=huge",
              "--with-compiledby='Chromebrew'",
              "--with-x=yes",
              "--enable-gui=gtk3",
              "--enable-multibyte",
              "--enable-cscope",
              "--enable-fontset",
              "--enable-perlinterp=dynamic",
              "--enable-pythoninterp=dynamic",
              "--enable-python3interp=dynamic",
              "--enable-rubyinterp=dynamic",
              "--disable-selinux"
    system "make"
  end

  def self.install
    system "make", "VIMRCLOC=#{CREW_PREFIX}/etc", "DESTDIR=#{CREW_DEST_DIR}", "install"

    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"

    # these are provided by 'vim_runtime'
    system "rm", "-r", "#{CREW_DEST_PREFIX}/share/vim"
  end

  def self.postinstall
    puts
    puts "The config files are located in #{CREW_PREFIX}/etc".lightblue
    puts "User-specific configuration should go in ~/.gvimrc".lightblue
    puts
    puts "If you are upgrading from an earlier version, edit ~/.bashrc".orange
    puts "and remove the 'export VIMRUNTIME' and 'export LC_ALL=C' lines.".orange
    puts
    puts "If you receive the following error while attempting to launch gvim:".orange
    puts
    puts "E233: cannot open display"
    puts "Press ENTER or type command to continue"
    puts "E852: The child process failed to start the GUI"
    puts "Press ENTER or type command to continue"
    puts
    puts "Execute the following:".orange
    puts "echo 'export GDK_BACKEND=x11' >> ~/.bashrc && source ~/.bashrc".orange
    puts
  end
end
