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
    depends_on 'gtk3'
    depends_on 'ffmpeg'
    depends_on 'jansson'
    depends_on 'nasm' => :build
    depends_on 'numactl'
    depends_on 'wayland_protocols'
    depends_on 'mesa'
    depends_on 'xcb_util'
  end

  def self.patch
    system "for f in \$(find -name '*.*'); do sed -i 's,/usr/include/libxml2,#{CREW_PREFIX}/include/libxml2,g' \$f; done"
  end

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    system "./configure --prefix=#{CREW_PREFIX} --enable-x265 --enable-numa --enable-fdk-aac --harden"
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
    puts "echo 'alias bluefish=\"WAYLAND_DISPLAY=wayland-0 DISPLAY=\'\' GDK_BACKEND=wayland bluefish\"' >> ~/.bashrc".lightblue
    puts
  end
end
