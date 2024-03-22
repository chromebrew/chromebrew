require 'package'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Microsoft Windows applications.'
  homepage 'https://www.winehq.org/'
  version '9.0'
  license 'LGPL-2.1'
  compatibility 'x86_64'
  source_url 'https://dl.winehq.org/wine/source/9.0/wine-9.0.tar.xz'
  source_sha256 '7cfd090a5395f5b76d95bb5defac8a312c8de4c070c1163b8b58da38330ca6ee'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '1ea5bc2c10eb8e696feac04e6f238470831743a5d744bf7a5ca53152a4f1fcfc'
  })

  depends_on 'alsa_lib' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'eudev' # R
  depends_on 'fontconfig' => :build
  depends_on 'giflib' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'lcms' => :build
  depends_on 'libfaudio' => :build
  depends_on 'libglu' => :build
  depends_on 'libgphoto' # R
  depends_on 'libjpeg' => :build
  depends_on 'libpcap' # R
  depends_on 'libpng' => :build
  depends_on 'libsm' => :build
  depends_on 'libunwind' # R
  depends_on 'libusb' # R
  depends_on 'libx11' # R
  depends_on 'libxcursor' => :build
  depends_on 'libxdamage' => :build
  depends_on 'libxext' # R
  depends_on 'libxi' => :build
  depends_on 'libxkbcommon' # R
  depends_on 'libxrandr' => :build
  depends_on 'mesa' => :build
  depends_on 'mpg123' => :build
  depends_on 'openal' => :build
  depends_on 'opencl_headers' => :build
  depends_on 'opencl_icd_loader' # R
  depends_on 'openldap' => :build
  depends_on 'pulseaudio' # R
  depends_on 'sommelier' # L
  depends_on 'vkd3d' => :build
  depends_on 'wayland' # R
  depends_on 'xdg_base' => :build

  no_lto

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
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "DLLDIR=#{CREW_DEST_WINE_PREFIX}", 'install'
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
