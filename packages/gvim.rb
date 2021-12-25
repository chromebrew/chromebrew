require 'package'

class Gvim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'http://www.vim.org/'
  @_ver = '8.2.3892'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvim/8.2.3892_armv7l/gvim-8.2.3892-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvim/8.2.3892_armv7l/gvim-8.2.3892-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvim/8.2.3892_i686/gvim-8.2.3892-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvim/8.2.3892_x86_64/gvim-8.2.3892-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '9d4b43270f40723ec270310d6a3504bf450ec5296af2554f30b224cb3f905b49',
     armv7l: '9d4b43270f40723ec270310d6a3504bf450ec5296af2554f30b224cb3f905b49',
       i686: '2ad1d7b9f85282153bb5699c347d20f979b42022e960ba4766378d17c0d0fd6c',
     x86_64: '76688066bd24c17cc3e45f4b68835905dbe3894f212ddc4dd1ec4c8dd486d610',
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
    end
  end

  def self.build
    system '[ -x configure ] || autoreconf -fvi'
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

    # these are provided by 'xxd_standalone'
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/xxd #{CREW_DEST_MAN_PREFIX}/man1/xxd.1]
    @deletefiles.each do |f|
      FileUtils.rm f if  File.exist?(f)
    end
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
