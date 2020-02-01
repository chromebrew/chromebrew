require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.2.0346'
  source_url 'https://github.com/vim/vim/archive/v8.2.0346.tar.gz'
  source_sha256 '418d1cbc9f53f31cb19869b6df0294ca5c377ca2824c759e3f6796edc60e5628'

  if ARGV[0] == 'install'
    gvim = `which gvim 2> /dev/null`.chomp
    abort "gvim version #{version} already installed.".lightgreen unless "#{gvim}" == ""
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.0346-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.0346-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.0346-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.0346-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0f362bab2d9dd493eb2acfdd8980e2baa6ad53af112452ea705f10e38bfa393a',
     armv7l: '0f362bab2d9dd493eb2acfdd8980e2baa6ad53af112452ea705f10e38bfa393a',
       i686: '417bc9e5aa1300bc877c4bc81d9fa6f75de7502874d0eeb9c6e6bf9948511f1d',
     x86_64: '2673362a6b1fef2f31c7a87ca45ec8dd045201e8331c86ec32d5f86fcca6acfb',
  })

  depends_on 'python27' => :build
  depends_on 'python3' => :build
  depends_on 'vim_runtime'

  def self.patch
    # set the system-wide vimrc path
    FileUtils.cd('src') do
      system "sed", "-i", "s|^.*#define SYS_VIMRC_FILE.*$|#define SYS_VIMRC_FILE \"#{CREW_PREFIX}/etc/vimrc\"|", "feature.h"
      system "sed", "-i", "s|^.*#define SYS_GVIMRC_FILE.*$|#define SYS_GVIMRC_FILE \"#{CREW_PREFIX}/etc/gvimrc\"|", "feature.h"
      system 'autoconf'
    end
  end

  def self.build
    system "./configure",
              "--prefix=#{CREW_PREFIX}",
              "--localstatedir=#{CREW_PREFIX}/var/lib/vim",
              '--with-features=huge',
              "--with-compiledby='Chromebrew'",
              '--with-x=no',
              '--disable-gui',
              '--enable-multibyte',
              '--enable-cscope',
              '--enable-fontset',
              '--enable-perlinterp=dynamic',
              '--enable-pythoninterp=dynamic',
              '--enable-python3interp=dynamic',
              '--enable-rubyinterp=dynamic',
              '--disable-selinux'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "VIMRCLOC=#{CREW_PREFIX}/etc", 'install'

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
