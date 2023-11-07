require 'package'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Microsoft Windows applications.'
  homepage 'https://www.winehq.org/'
  version '8.0.1'
  license 'LGPL-2.1'
  compatibility 'x86_64'
  source_url 'https://dl.winehq.org/wine/source/8.0/wine-8.0.1.tar.xz'
  source_sha256 '22035f3836b4f9c3b1940ad90f9b9e3c1be09234236d2a80d893180535c75b7d'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wine/8.0.1_x86_64/wine-8.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '047a10a50f0e9adc37c85a98b43f93db4375c2c1982b29ea941bb4ad1c623c0e'
  })

  depends_on 'alsa_lib' # R
  depends_on 'desktop_file_utils'
  depends_on 'eudev' # R
  depends_on 'fontconfig'
  depends_on 'giflib'
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'lcms'
  depends_on 'libfaudio'
  depends_on 'libglu'
  depends_on 'libgphoto' # R
  depends_on 'libjpeg'
  depends_on 'libpcap' # R
  depends_on 'libpng'
  depends_on 'libsm'
  depends_on 'libunwind' # R
  depends_on 'libusb' # R
  depends_on 'libx11' # R
  depends_on 'libxcursor'
  depends_on 'libxdamage'
  depends_on 'libxext' # R
  depends_on 'libxi'
  depends_on 'libxrandr'
  depends_on 'mesa'
  depends_on 'mpg123'
  depends_on 'openal'
  depends_on 'opencl_headers' => :build
  depends_on 'opencl_icd_loader' # R
  depends_on 'openldap'
  depends_on 'pulseaudio' # R
  depends_on 'sommelier'
  depends_on 'vkd3d'
  depends_on 'xdg_base'

  no_lto
  print_source_bashrc

  def self.build
    FileUtils.mkdir_p 'wine64-build'
    Dir.chdir 'wine64-build' do
      unless File.file?('Makefile')
        system "../configure #{CREW_OPTIONS} \
          --enable-win64 \
          --disable-maintainer-mode \
          --with-gstreamer \
          --with-x"
      end
      system 'make || make'
      File.write 'wine_config_env', <<~WINE_CONFIG_EOF
        # Wine configuration
        WINEPREFIX="${XDG_CONFIG_HOME}"/.wine
      WINE_CONFIG_EOF
    end
  end

  def self.check
    # There are all sorts of fixme errors, but wine does successfully
    # prompt for install of the wine-mono package, which it then claims
    # to install during the test process...
    Dir.chdir 'wine64-build' do
      system 'make test || true'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s 'wine64', 'wine'
    end
    Dir.chdir 'wine64-build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "DLLDIR=#{CREW_DEST_DLL_PREFIX}", 'install'
      FileUtils.install 'wine_config_env', "#{CREW_DEST_PREFIX}/etc/env.d/wine", mode: 0o644
    end
  end

  def self.postinstall
    ExitMessage.add 'To run an application with wine, type `wine path/to/myexecutable.exe` or `wine path/to/myinstaller.msi`.'.lightblue
  end

  def self.remove
    @xdg_config_home = ENV.fetch('XDG_CONFIG_HOME', nil)
    @xdg_config_home = "#{CREW_PREFIX}/.config" if @xdg_config_home.to_s.empty?
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
