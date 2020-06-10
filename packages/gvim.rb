require 'package'

class Gvim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'http://www.vim.org/'
  version '8.2.0346'
  compatibility 'all'
  source_url 'https://github.com/vim/vim/archive/v8.2.0346.tar.gz'
  source_sha256 '418d1cbc9f53f31cb19869b6df0294ca5c377ca2824c759e3f6796edc60e5628'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.2.0346-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.2.0346-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.2.0346-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gvim-8.2.0346-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0470196bc08f2217d4621b513797fe472aea4b426c987361739ef978ba2b654b',
     armv7l: '0470196bc08f2217d4621b513797fe472aea4b426c987361739ef978ba2b654b',
       i686: 'c3c8b0ae067acff18ef3167c79694cb99f91170e0091ae9ca2e5d51cfd8a8385',
     x86_64: 'b0427f0c3fdb2cbb892be3de830515171457899ace33758538a9313f375abe9f',
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
    system "make"
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
