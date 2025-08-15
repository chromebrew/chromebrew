require 'buildsystems/autotools'
Package.load_package("#{__dir__}/vim_runtime.rb")

class Gvim < Autotools
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient. (with advanced features, such as a GUI)'
  homepage 'https://www.vim.org/'
  version Vim_runtime.version
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url Vim_runtime.source_url
  git_hashtag Vim_runtime.git_hashtag
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69db945f5f50194729e6596644f57bdfc49a72ada91f2ec1a8eab45df7a29cbd',
     armv7l: '69db945f5f50194729e6596644f57bdfc49a72ada91f2ec1a8eab45df7a29cbd',
     x86_64: '34466ada945bab4e3b07b74c9870624c08c65dff0349ba817538a5e48af05067'
  })

  depends_on 'acl' # R
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gpm' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz'
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libsodium' # R
  depends_on 'libx11' # R
  depends_on 'libxt' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'vim_runtime' # L
  depends_on 'wayland' # R

  ignore_updater

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

  autotools_configure_options "--localstatedir=#{CREW_PREFIX}/var/lib/vim \
    --disable-canberra \
    --disable-nls \
    --disable-selinux \
    --enable-acl \
    --enable-cscope \
    --enable-gnome-check \
    --enable-gpm \
    --enable-gui=gtk3 \
    --enable-luainterp=dynamic \
    --enable-multibyte \
    --enable-netbeans \
    --enable-perlinterp=dynamic \
    --enable-python3interp=dynamic \
    --enable-pythoninterp=dynamic \
    --enable-rubyinterp=dynamic \
    --enable-tclinterp=dynamic \
    --with-compiledby='Chromebrew' \
    --with-features=huge \
    --with-x=yes"

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
      if Package.agree_default_yes('Would you like to set vim to be the default vi')
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

  def self.postremove
    # Remove vi symlink if it is to vim.
    return unless File.symlink?("#{CREW_PREFIX}/bin/vi") && (File.readlink("#{CREW_PREFIX}/bin/vi") == "#{CREW_PREFIX}/bin/vim")

    FileUtils.rm "#{CREW_PREFIX}/bin/vi"
  end
end
