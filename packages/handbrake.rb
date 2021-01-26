require 'package'

class Handbrake < Package
  description 'HandBrake is a tool for converting video from nearly any format to a selection of modern, widely supported codecs.'
  homepage 'https://handbrake.fr/'
  version '1.3.3-1'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/HandBrake/HandBrake/releases/download/1.3.3/HandBrake-1.3.3-source.tar.bz2'
    source_sha256 '218a37d95f48b5e7cf285363d3ab16c314d97627a7a710cab3758902ae877f85'

    binary_url ({
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/handbrake-1.3.3-1-chromeos-x86_64.tar.xz',
  })
    binary_sha256 ({
      x86_64: '13e06c6458fe918ab1a46deeadcea9415c00be877a333b9bfbe5969c1ca1ba2a',
  })
    
    depends_on 'gtk3'
    depends_on 'ffmpeg'
    depends_on 'jansson'
    depends_on 'nasm' => :build
    depends_on 'numactl'
    depends_on 'wayland_protocols'
    depends_on 'mesa'
    depends_on 'xcb_util'
    depends_on 'freetype'
  end

  def self.patch
    system "for f in \$(find -name '*.*'); do sed -i 's,/usr/include/libxml2,#{CREW_PREFIX}/include/libxml2,g' \$f; done"
  end

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure --prefix=#{CREW_PREFIX} --enable-x265 --enable-numa --enable-fdk-aac --harden"
    Dir.chdir 'build' do
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.postinstall
    puts
    puts "To get started, type 'ghb'.".lightblue
    puts
    puts "Type 'HandBrakeCLI' for the command line.".lightblue
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'alias ghb=\"WAYLAND_DISPLAY=wayland-0 DISPLAY=\'\' GDK_BACKEND=wayland ghb\"' >> ~/.bashrc".lightblue
    puts
  end
end
