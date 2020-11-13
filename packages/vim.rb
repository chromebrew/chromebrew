require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.2.1976'
  compatibility 'all'
  source_url 'https://github.com/vim/vim/archive/v8.2.1976.tar.gz'
  source_sha256 'd2d8bc28e28e9c5a63be570cdb44be39470621bb57dcbace5abbd86e15690678'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.1976-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.1976-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.1976-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.1976-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd7f92124ba6fc6d6188ab872205fe8e9a866475b6dec9e4a7e88933620284068',
     armv7l: 'd7f92124ba6fc6d6188ab872205fe8e9a866475b6dec9e4a7e88933620284068',
       i686: '4439db5c399b4ed5a82128c2a97ca16125be842f0bad4a234566083c239ccd96',
     x86_64: '7e5660fa1d751e53a6012727fed17e3b4dea23ec3adc1750a1189d9b5908e579',
  })

  depends_on 'vim_runtime'

  def self.preinstall
    gvim = `which gvim 2> /dev/null`.chomp
    abort "gvim version #{version} already installed.".lightgreen unless "#{gvim}" == ""
  end

  def self.patch
    # set the system-wide vimrc path
    FileUtils.cd('src') do
      system "sed", "-i", "s|^.*#define SYS_VIMRC_FILE.*$|#define SYS_VIMRC_FILE \"#{CREW_PREFIX}/etc/vimrc\"|", "feature.h"
      system "sed", "-i", "s|^.*#define SYS_GVIMRC_FILE.*$|#define SYS_GVIMRC_FILE \"#{CREW_PREFIX}/etc/gvimrc\"|", "feature.h"
      system 'autoconf'
    end
  end

  def self.build
    system './configure',
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
