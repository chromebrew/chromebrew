require 'package'

class Gvim < Package
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'http://www.vim.org/'
  version '9.0.1145'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvim/9.0.1145_armv7l/gvim-9.0.1145-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvim/9.0.1145_armv7l/gvim-9.0.1145-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvim/9.0.1145_i686/gvim-9.0.1145-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gvim/9.0.1145_x86_64/gvim-9.0.1145-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd8edb31697fd1e5f229f4e6cd508fbc63dc8a6c6eb48cdf38f4e5f058b9a2aa4',
     armv7l: 'd8edb31697fd1e5f229f4e6cd508fbc63dc8a6c6eb48cdf38f4e5f058b9a2aa4',
       i686: '61bc60db3c6ec2c9ecc3f6805880858f35be16037846cd4cd3d16608c6c35d86',
     x86_64: '0e83d2ea39503b2e2214a800a9c6008b81f27fde3d24318ec05c5ec04f4a5e75'
  })

  depends_on 'vim_runtime'
  depends_on 'gtk3'
  depends_on 'sommelier'
  depends_on 'acl' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gpm' # R
  depends_on 'gtk2' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libsodium' # R
  depends_on 'libx11' # R
  depends_on 'libxt' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R

  def self.preflight
    vim = `which #{CREW_PREFIX}/bin/vim 2> /dev/null`.chomp
    abort "vim version #{version} already installed.".lightgreen unless vim.to_s == ''
  end

  def self.patch
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
    system "./configure \
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
      FileUtils.rm_f f
    end
  end

  def self.postinstall
    puts
    puts "The config files are located in #{CREW_PREFIX}/etc.".lightblue
    puts 'User-specific configuration should go in ~/.vimrc and'.lightblue
    puts '~/.gvimrc.'.lightblue
    puts
    puts 'If you are upgrading from an earlier version, edit ~/.bashrc'.orange
    puts "and remove the 'export VIMRUNTIME' and 'export LC_ALL=C' lines.".orange
    # Set vim to be the default vi if there is no vi or if a default
    # vi does not exist.
    @crew_vi = File.file?("#{CREW_PREFIX}/bin/vi")
    @system_vi = File.file?('/usr/bin/vi')
    @create_vi_symlink = true if !@system_vi && !@crew_vi
    @create_vi_symlink_ask = true if @crew_vi || @system_vi
    if @create_vi_symlink_ask
      print "\nWould you like to set vim to be the default vi [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        @create_vi_symlink = true
      else
        @create_vi_symlink = false
        puts 'Default vi left unchanged.'.lightgreen
      end
    end
    return unless @create_vi_symlink

    FileUtils.ln_sf "#{CREW_PREFIX}/bin/vim", "#{CREW_PREFIX}/bin/vi"
    puts 'Default vi set to vim.'.lightgreen
  end

  def self.remove
    # Remove vi symlink if it is to vim.
    return unless File.symlink?("#{CREW_PREFIX}/bin/vi") && (File.readlink("#{CREW_PREFIX}/bin/vi") == "#{CREW_PREFIX}/bin/vim")

    FileUtils.rm "#{CREW_PREFIX}/bin/vi"
  end
end
