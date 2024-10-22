require 'buildsystems/autotools'

class Vim < Autotools
  description 'Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.'
  homepage 'https://www.vim.org/'
  version '9.1.0758'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9607dd384bc7fb458c7df553ca57204a50d1582fc98b8a51746d2945b9dc0052',
     armv7l: '9607dd384bc7fb458c7df553ca57204a50d1582fc98b8a51746d2945b9dc0052',
       i686: 'fe8d07640f06016f6026ca0a03a0b3d4a9363c14adfa0ffa105a92a565884c47',
     x86_64: '1daa3c80ced797449f0ef997a7350c9c93c23f5e9281b712e56d24afd7cd88f4'
  })

  depends_on 'vim_runtime' # R
  depends_on 'acl' # R
  depends_on 'glibc' # R
  depends_on 'gpm' # R
  depends_on 'libsodium' # R
  depends_on 'ncurses' # R

  def self.preflight
    gvim = `which #{CREW_PREFIX}/bin/gvim 2> /dev/null`.chomp
    abort "gvim version #{version} already installed.".lightgreen unless gvim.to_s == ''
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

  configure_options "--localstatedir=#{CREW_PREFIX}/var/lib/vim \
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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "VIMRCLOC=#{CREW_PREFIX}/etc", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/vim", "#{CREW_DEST_PREFIX}/bin/vi"

    # these are provided by 'vim_runtime'
    FileUtils.rm_r "#{CREW_DEST_PREFIX}/share/vim"

    # these are provided by 'xxd_standalone'
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/xxd #{CREW_DEST_MAN_PREFIX}/man1/xxd.1]
    @deletefiles.each do |f|
      FileUtils.rm_f f
    end

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
