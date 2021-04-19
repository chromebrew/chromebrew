require 'package'

class Gvim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'http://www.vim.org/'
  @_ver = '8.2.2783'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gvim-8.2.2783-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gvim-8.2.2783-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gvim-8.2.2783-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gvim-8.2.2783-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bb178b2d66d9a84237b4f4dfacd78befa7a5b88baffe0f49f8bacee045dda6bd',
     armv7l: 'bb178b2d66d9a84237b4f4dfacd78befa7a5b88baffe0f49f8bacee045dda6bd',
       i686: 'a0ad2d39ab72c9d5f827fdb0bdaeb39ca6cd64114f4520f3979f43852dcf9458',
     x86_64: '979a27bf60ed3af9e08d61c159d51d39dade3f32818d57e50fd846f9a840935d'
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
