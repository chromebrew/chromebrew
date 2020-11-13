require 'package'

class Gvim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'http://www.vim.org/'
  version '8.2.1976'
  compatibility 'all'
  source_url 'https://github.com/vim/vim/archive/v8.2.1976.tar.gz'
  source_sha256 'd2d8bc28e28e9c5a63be570cdb44be39470621bb57dcbace5abbd86e15690678'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.2.1976-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.2.1976-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.2.1976-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.2.1976-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3bec0434e49ab556c45b6755e858d8a1bf917f238e2906a35a7fbcffebe575bb',
     armv7l: '3bec0434e49ab556c45b6755e858d8a1bf917f238e2906a35a7fbcffebe575bb',
       i686: '62a0405196e9e701f54025447bfe23e59554e5c5abe298d080246384378a6a28',
     x86_64: '087edd65ce9f13039ab9d8d9a8c6a5c9d6c02f47ad9a2c519970085d8999473f',
  })

  depends_on 'vim_runtime'
  depends_on 'gtk3'
  depends_on 'sommelier'

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
           '--with-x=yes',
           '--enable-gui=gtk3',
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
    system 'make', "VIMRCLOC=#{CREW_PREFIX}/etc", "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # these are provided by 'vim_runtime'
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/vim"
  end

  def self.postinstall
    puts
    puts "The config files are located in #{CREW_PREFIX}/etc".lightblue
    puts "User-specific configuration should go in ~/.gvimrc".lightblue
    puts
    puts "If you are upgrading from an earlier version, edit ~/.bashrc".orange
    puts "and remove the 'export VIMRUNTIME' and 'export LC_ALL=C' lines.".orange
    puts
  end
end
