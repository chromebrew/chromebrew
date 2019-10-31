require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.1.2234'
  source_url 'https://github.com/vim/vim/archive/v8.1.2234.tar.gz'
  source_sha256 '08c8f8cdc41583e1604fdb27697f5cce7cf6ca01506b7ad3c6fe6d5ea722878b'

  if ARGV[0] == 'install'
    gvim = `which gvim 2> /dev/null`.chomp
    abort "gvim version #{version} already installed.".lightgreen unless "#{gvim}" == ""
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.2234-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.2234-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.2234-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.2234-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7cc653078f9418cb0e792a60722235acb7fe365d32a4dfa6e79fb82cdb5c5e7b',
     armv7l: '7cc653078f9418cb0e792a60722235acb7fe365d32a4dfa6e79fb82cdb5c5e7b',
       i686: 'c390fb82b8e94516a9d4a2982e490f32256a787b28805e277d7266db03ba427f',
     x86_64: '8badba752b1feeba5ee285c015dc52e95e29514afa3b317e7fd87390e42bbc02',
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
