require 'package'

class Vim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'http://www.vim.org/'
  @_ver = '8.2.2725'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/vim/vim/archive/refs/tags/v#{@_ver}.tar.gz"
  source_sha256 'a8aca906cf63fdc4264f86c1c39f8164989de0be3dc18553cb23bd6226c361a9'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/vim-8.2.2725-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/vim-8.2.2725-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/vim-8.2.2725-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/vim-8.2.2725-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c7c267037313e808abd4106eff6c2ae47e6cd95ccc2c97fd84ba0034efc9a0ed',
     armv7l: 'c7c267037313e808abd4106eff6c2ae47e6cd95ccc2c97fd84ba0034efc9a0ed',
       i686: '596357e4b5a9b098d6724a26dc120dbc8b3bccf3d7d706caa604a7fc1aa44036',
     x86_64: 'a46443dd0cd6b6b8f924cb0f531154c5ac551bddcaa2e9ea52b93d18ae0864fc'
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
