require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  @_ver = '8.2.2580'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/vim/vim/archive/v8.2.2580.tar.gz'
  source_sha256 'd0a508ca9726c8ff69bc5f5ab1ebe251c256e01e730f7b36afd03a66c89fcf79'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.2580-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.2580-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.2580-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vim-8.2.2580-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fc753eff299bb106dde43f55f7b52d40852f3f2b0651eb869afad92eb1c5132c',
     armv7l: 'fc753eff299bb106dde43f55f7b52d40852f3f2b0651eb869afad92eb1c5132c',
       i686: 'a830cb5b36fe8752b90829f5b97dc382868d7dfda4462ed7cb3e37eebd27939a',
     x86_64: '27f86977743855f0f77f9797a80674eda93977a4309a02bff399364237984104'
  })

  depends_on 'vim_runtime'

  def self.preflight
    gvim = `which #{CREW_PREFIX}/bin/gvim 2> /dev/null`.chomp
    abort "gvim version #{version} already installed.".lightgreen unless gvim.to_s == ''
  end

  def self.patch
    abort('Please remove libiconv before building.') if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")
    # set the system-wide vimrc path
    FileUtils.cd('src') do
      system 'sed', '-i', "s|^.*#define SYS_VIMRC_FILE.*$|#define SYS_VIMRC_FILE \"#{CREW_PREFIX}/etc/vimrc\"|",
             'feature.h'
      system 'sed', '-i', "s|^.*#define SYS_GVIMRC_FILE.*$|#define SYS_GVIMRC_FILE \"#{CREW_PREFIX}/etc/gvimrc\"|",
             'feature.h'
      system 'autoconf'
    end
  end

  def self.build
    system './configure --help'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --localstatedir=#{CREW_PREFIX}/var/lib/vim \
      --with-features=huge \
      --with-compiledby='Chromebrew' \
      --enable-gpm \
      --enable-acl \
      --with-x=no \
      --disable-gui \
      --enable-multibyte \
      --enable-cscope \
      --enable-netbeans \
      --enable-perlinterp=dynamic \
      --enable-pythoninterp=dynamic \
      --enable-python3interp=dynamic \
      --enable-rubyinterp=dynamic \
      --enable-luainterp=dynamic \
      --enable-tclinterp=dynamic \
      --disable-canberra \
      --disable-selinux \
      --disable-nls"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "VIMRCLOC=#{CREW_PREFIX}/etc", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/vim", "#{CREW_DEST_PREFIX}/bin/vi"

    # these are provided by 'vim_runtime'
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/vim"

    # remove desktop and icon files for the terminal package
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/icons"
  end

  def self.postinstall
    puts
    puts "The config files are located in #{CREW_PREFIX}/etc.".lightblue
    puts 'User-specific configuration should go in ~/.vimrc.'.lightblue
    puts
    puts 'If you are upgrading from an earlier version, edit ~/.bashrc'.orange
    puts "and remove the 'export VIMRUNTIME' and 'export LC_ALL=C' lines.".orange
    puts
  end
end
