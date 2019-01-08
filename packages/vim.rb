require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  version '8.1.0648'
  source_url 'https://github.com/vim/vim/archive/v8.1.0648.tar.gz'
  source_sha256 '7e6ad44dbb8fda0aca91c22fa0dcaed2d845cf00c26d6d3df3bfaa38c9da222a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.0648-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.0648-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.0648-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.1.0648-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ad8a65a09ee223bd7ac08026617eb1738ea9f00263a588840d3bc94f804aec6',
     armv7l: '3ad8a65a09ee223bd7ac08026617eb1738ea9f00263a588840d3bc94f804aec6',
       i686: '9e94cb4b28b8b7e6a3cd70081d85b4a2950209aa085611aa5def722f9ae585fa',
     x86_64: '03d46bc71c2785601e95b5e898b198dac56fae7810907d0beab0f08fe7c576f2',
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

    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"

    # these are provided by 'vim_runtime'
    system "rm", "-r", "#{CREW_DEST_PREFIX}/share/vim"

    # remove desktop and icon files for the cli package
    system "rm", "-r", "#{CREW_DEST_PREFIX}/share/applications"
    system "rm", "-r", "#{CREW_DEST_PREFIX}/share/icons"
  end

  def self.postinstall
    puts
    puts "The config files are located in #{CREW_PREFIX}/etc".lightblue
    puts "User-specific configuration should go in ~/.vimrc".lightblue
    puts
    puts "If you are upgrading from an earlier version, edit ~/.bashrc".orange
    puts "and remove the 'export VIMRUNTIME' line.".orange
    puts
  end
end
