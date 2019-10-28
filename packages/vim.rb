require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.1.2225'
  source_url 'https://github.com/vim/vim/archive/v8.1.2225.tar.gz'
  source_sha256 'a88cf5fb07701d92ea79a3cc8f6e020e6b9bf07c0dfa72f0dde8a65f87e30f2d'

  if ARGV[0] == 'install'
    gvim = `which gvim 2> /dev/null`.chomp
    abort "gvim version #{version} already installed.".lightgreen unless "#{gvim}" == ""
  end

  binary_url ({
  })
  binary_sha256 ({
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

    # remove desktop and icon files for the terminal package
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/icons"
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
