require 'package'

class Handbrake < Package
  description 'HandBrake is a tool for converting video from nearly any format to a selection of modern, widely supported codecs.'
  homepage 'https://handbrake.fr/'
  version '1.6-d260dde'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/HandBrake/HandBrake.git'
  git_hashtag 'd260ddeb569330500baddc8433491842fb954861'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/handbrake/1.6-d260dde_x86_64/handbrake-1.6-d260dde-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '95ffecf8fe9eba20ef4f85e1091330930ca9742ec467b64d047684b734b8998c'
  })

  depends_on 'atk' # R
  depends_on 'at_spi2_core' # R
  depends_on 'bz2' # R
  depends_on 'expat' # R
  depends_on 'ffmpeg'
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'intel_media_sdk' if ARCH == 'x86_64'
  depends_on 'jansson' # R
  depends_on 'libass' # R
  depends_on 'libdvdcss'
  depends_on 'libgudev' # R
  depends_on 'libjpeg' # R
  depends_on 'libmp3lame' # R
  depends_on 'libogg' # R
  depends_on 'libpng' # R
  depends_on 'libtheora' # R
  depends_on 'libva' # R
  depends_on 'libvorbis' # R
  depends_on 'libvpx' # R
  depends_on 'libx264' # R
  depends_on 'libxml2' # R
  depends_on 'mesa'
  depends_on 'nasm' => :build
  depends_on 'numactl' # R
  depends_on 'onevpl' if ARCH == 'x86_64' # R
  depends_on 'opus' # R
  depends_on 'pango' # R
  depends_on 'speex' # R
  depends_on 'util_linux' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'xcb_util' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  no_env_options

  def self.build
    system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure #{CREW_OPTIONS} \
      --enable-x265 \
      --enable-numa \
      --enable-fdk-aac \
      --enable-qsv \
      --no-harden \
      --force"
    FileUtils.mkdir_p 'x86_64-cros-linux-gnu/contrib/lib/pkgconfig'
    Dir.chdir('x86_64-cros-linux-gnu/contrib/lib/pkgconfig') do
      @handbrake_libs = %w[glib-2.0 fribidi harfbuzz freetype]
      @handbrake_libs.each do |f|
        next if File.file?("#{f}.pc")

        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/pkgconfig/#{f}.pc", "#{f}.pc"
      end
    end
    system 'make -C x86_64-cros-linux-gnu || make -j1 -C x86_64-cros-linux-gnu'
  end

  def self.install
    Dir.chdir 'x86_64-cros-linux-gnu' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-handbrake", <<~'HANDBRAKE_ENVD_EOF'
      alias ghb="GDK_BACKEND=wayland ghb"
    HANDBRAKE_ENVD_EOF
  end
end

def self.postinstall
  puts
  puts "To get started, type 'ghb'.".lightblue
  puts
  puts "Type 'HandBrakeCLI' for the command line.".lightblue
  puts
  puts 'Please run the following to finish the install:'.orange
  puts "source #{CREW_PREFIX}/etc/env.d/10-handbrake".lightblue
  puts
end
