require 'package'

class Gvim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'http://www.vim.org/'
  @_ver = '8.2.2725'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/vim/vim/archive/refs/tags/v#{@_ver}.tar.gz"
  source_sha256 'a8aca906cf63fdc4264f86c1c39f8164989de0be3dc18553cb23bd6226c361a9'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gvim-8.2.2725-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gvim-8.2.2725-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gvim-8.2.2725-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gvim-8.2.2725-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0c813f4f93053af3d50e6bad0de4742eba2a99bed72ca5ca239fdf1b31d42b69',
     armv7l: '0c813f4f93053af3d50e6bad0de4742eba2a99bed72ca5ca239fdf1b31d42b69',
       i686: '2b9dd78e45e4543874fb5f5237e33edcf8c6ece04b9263c992ca4d9e7200a486',
     x86_64: '177d45f4f3dd52e3148d46ab4de6b4ffe9f91b0ead63f9e75d5891a1ce1ff706'
  })

  depends_on 'vim_runtime'
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.preflight
    vim = `which #{CREW_PREFIX}/bin/vim 2> /dev/null`.chomp
    abort "vim version #{version} already installed.".lightgreen unless vim.to_s == ''
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
      --with-x=yes \
      --enable-gnome-check \
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
    system 'make', "VIMRCLOC=#{CREW_PREFIX}/etc", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/vim", "#{CREW_DEST_PREFIX}/bin/vi"

    # these are provided by 'vim_runtime'
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/vim"
  end

  def self.postinstall
    puts
    puts "The config files are located in #{CREW_PREFIX}/etc".lightblue
    puts 'User-specific configuration should go in ~/.gvimrc'.lightblue
    puts
    puts 'If you are upgrading from an earlier version, edit ~/.bashrc'.orange
    puts "and remove the 'export VIMRUNTIME' and 'export LC_ALL=C' lines.".orange
    puts
  end
end
