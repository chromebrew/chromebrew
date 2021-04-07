require 'package'
require 'fileutils'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Windows applications on several POSIX-compliant operating systems, such as Linux, macOS, & BSD.'
  homepage 'https://www.winehq.org/'
  version '6.5'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://dl.winehq.org/wine/source/6.x/wine-6.5.tar.xz'
  source_sha256 '0600fd208c06925d6634d29f543bba0a64361c34e9bd7609c2f0e209610ad347'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wine-6.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wine-6.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wine-6.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wine-6.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b9be4a9acbe76ba54be0671952221a019240811a27e94f53c40e5fb67e0624a3',
     armv7l: 'b9be4a9acbe76ba54be0671952221a019240811a27e94f53c40e5fb67e0624a3',
       i686: '35ccf55f9abc5f022a6f5756db2ac97c0c9a6dd5f644e6421805c64b6a335ec3',
     x86_64: '01113b6f570b01b8598b38a478ed1bfe55b9cec63ed5f1683a52153f51fb3b6d'
  })

  depends_on 'alsa_lib'
  depends_on 'eudev'
  depends_on 'glib'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'lcms'
  depends_on 'libgphoto'
  depends_on 'libpcap'
  depends_on 'libunwind'
  depends_on 'libusb'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'mpg123'
  depends_on 'openal'
  depends_on 'pulseaudio'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  @xdg_config_home = empty?(ENV['XDG_CONFIG_HOME']) ? "#{CREW_PREFIX}/.config" : ENV['XDG_CONFIG_HOME']
  
  def self.build
    case ARCH
    when 'x86_64'
      FileUtils.mkdir 'wine64-build'
      Dir.chdir 'wine64-build' do
        system "../configure #{CREW_OPTIONS} \
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
        system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      end
    else
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @wine_config_env = <<~'WINE_CONFIG_EOF'
      # Wine configuration
      WINEPREFIX="${XDG_CONFIG_HOME}"/.wine
    WINE_CONFIG_EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/wine", @wine_config_env)
  end

  def self.postinstall
    puts
    puts "Type 'WINEPREFIX=#{@xdg_config_home}/.wine wine explorer' to get started using the file explorer.".lightblue
    puts
  end

  def self.remove
    config_dirs = ["#{HOME}/.wine", "#{@xdg_config_home}/.wine"]
    config_dirs.each { |config_dir|                                                                                                                                                           
      if Dir.exists? config_dir                                                                                                                                                               
        print "\nWould you like to remove #{config_dir}? [y/N] "                                                                                                                                
        case STDIN.getc                                                                                                                                                                       
        when "y", "Y"                                                                                                                                                                         
          FileUtils.rm_rf config_dir                                                                                                                                                          
          puts "#{config_dir} removed.".lightred                                                                                                                                              
        else                                                                                                                                                                                  
          puts "#{config_dir} saved.".lightgreen                                                                                                                                              
        end                                                                                                                                                                                   
      end                                                                                                                                                                                     
    }
  end
end
