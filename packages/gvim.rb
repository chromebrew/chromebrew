require 'package'

class Gvim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'http://www.vim.org/'
  version '8.1.2234'
  source_url 'https://github.com/vim/vim/archive/v8.1.2234.tar.gz'
  source_sha256 '08c8f8cdc41583e1604fdb27697f5cce7cf6ca01506b7ad3c6fe6d5ea722878b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1.2234-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1.2234-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1.2234-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.1.2234-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '47204371c00c425601c5e776cda6af823f62992a83e789ec498ad09b0c53c047',
     armv7l: '47204371c00c425601c5e776cda6af823f62992a83e789ec498ad09b0c53c047',
       i686: 'e4823c4a0b51214de900f834e7eff0a964e142618eacd3938d6420fd85a386e3',
     x86_64: 'e25443c9f0baebb25b6f44018c2b07150775dfadee3152d14a6d07c3a5190f9d',
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
