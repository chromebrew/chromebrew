require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.1.1852'
  source_url 'https://github.com/vim/vim/archive/v8.1.1852.tar.gz'
  source_sha256 'd543a06a075596e10d1ab4964b6a312ac78c7ccd0628d8b1d6b5deeb7b1d252e'

  if ARGV[0] == 'install'
    gvim = `which gvim 2> /dev/null`.chomp
    abort "gvim version #{version} already installed.".lightgreen unless "#{gvim}" == ""
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.1852-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.1852-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.1852-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.1852-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '40b96c99b8e11e6f6a3ecab42be9d04607d4f3cc1f45f9b9fec5c98f06edb6aa',
     armv7l: '40b96c99b8e11e6f6a3ecab42be9d04607d4f3cc1f45f9b9fec5c98f06edb6aa',
       i686: 'a9071472830d4e12fca6095647c03db45fa4976c8b103a597f77e2dcb42e2001',
     x86_64: '461e2bc30c8d55afdf0b785968ada2f811469e5a84777083be195d325b954f22',
  })

  depends_on 'python27' => :build
  depends_on 'python3' => :build
  depends_on 'vim_runtime'

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
              "--with-x=no",
              "--disable-gui",
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
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "VIMRCLOC=#{CREW_PREFIX}/etc", "install"

    # these are provided by 'vim_runtime'
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/vim"
  end

  def self.postinstall
    puts
    puts "The config files are located in #{CREW_PREFIX}/etc.".lightblue
    puts "User-specific configuration should go in ~/.vimrc.".lightblue
    puts
    puts "If you are upgrading from an earlier version, edit ~/.bashrc".orange
    puts "and remove the 'export VIMRUNTIME' and 'export LC_ALL=C' lines.".orange
    puts
  end
end
