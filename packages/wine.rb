require 'package'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Microsoft Windows applications.'
  homepage 'https://www.winehq.org/'
  version '7.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://dl.winehq.org/wine/source/7.x/wine-7.1.tar.xz'
  source_sha256 '113c130eed2f3256c932ffbb7f482a0533ed3ac5c62c979622a2a6df7f9f636a'

  depends_on 'alsa_lib'
  depends_on 'desktop_file_utils'
  depends_on 'eudev'
  depends_on 'fontconfig'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'gstreamer'
  depends_on 'lcms'
  depends_on 'libfaudio'
  depends_on 'libglu'
  depends_on 'libgphoto'
  depends_on 'libjpeg'
  depends_on 'openldap'
  depends_on 'libpcap'
  depends_on 'libpng'
  depends_on 'libsm'
  depends_on 'libunwind'
  depends_on 'libusb'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxcursor'
  depends_on 'libxdamage'
  depends_on 'libxi'
  depends_on 'libxrandr'
  depends_on 'mesa'
  depends_on 'mpg123'
  depends_on 'openal'
  depends_on 'opencl_headers' => :build
  dependS_on 'opencl_icd_loader'
  depends_on 'pulseaudio'
  depends_on 'vkd3d'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  @xdg_config_home = ENV.fetch('XDG_CONFIG_HOME', nil)
  @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?

  def self.build
    case ARCH
    when 'x86_64'
      FileUtils.mkdir 'wine64-build'
      Dir.chdir 'wine64-build' do
        system "#{CREW_ENV_FNO_LTO_OPTIONS} ../configure #{CREW_OPTIONS} \
          --enable-win64 \
          --disable-maintainer-mode \
          --with-x"
        system 'make'
      end
      # Needs a 32 bit compiler, which we don't have on x86_64
      # FileUtils.mkdir 'wine32-build'
      # Dir.chdir 'wine32-build' do
      # system "../configure #{CREW_OPTIONS} \
      #--with-wine64=../wine64-build \
      #--disable-maintainer-mode \
      #--with-x"
      # system 'make'
      # end
    else
      system "./configure #{CREW_OPTIONS} \
        --disable-maintainer-mode \
        --with-x"
    end
    system 'make'
  end

  def self.install
    case ARCH
    when 'x86_64'
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
        FileUtils.ln_s 'wine64', 'wine'
      end
      Dir.chdir 'wine64-build' do
        system 'make', "DESTDIR=#{CREW_DEST_DIR}", "DLLDIR=#{CREW_DEST_DLL_PREFIX}", 'install'
      end
    else
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "DLLDIR=#{CREW_DEST_DLL_PREFIX}", 'install'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @wine_config_env = <<~'WINE_CONFIG_EOF'
      # Wine configuration
      WINEPREFIX="${XDG_CONFIG_HOME}"/.wine
    WINE_CONFIG_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/wine", @wine_config_env)
  end

  def self.postinstall
    puts
    puts "To run an application with wine, type `wine path/to/myexecutable.exe` or `wine path/to/myinstaller.msi`.".lightblue
    puts
  end

  def self.remove
    config_dirs = ["#{HOME}/.wine", "#{@xdg_config_home}/.wine"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir

      print "\nWould you like to remove #{config_dir}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightblue
      end
    end
  end
end
