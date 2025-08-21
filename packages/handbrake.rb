require 'package'
require 'convenience_functions'

class Handbrake < Package
  description 'HandBrake is a tool for converting video from nearly any format to a selection of modern, widely supported codecs.'
  homepage 'https://handbrake.fr/'
  version '1.10.0'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/HandBrake/HandBrake.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '4a1cbdaab5931a9e878f3103cb9df6750e44ca8f6272fc80aa924ddf15cd3d64'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'ffmpeg' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphene' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'intel_media_sdk'
  depends_on 'jansson' # R
  depends_on 'libass' # R
  depends_on 'libdrm' # R
  depends_on 'libdvdcss'
  depends_on 'libgudev' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libmp3lame' # R
  depends_on 'libogg' # R
  depends_on 'libpng' # R
  depends_on 'libtheora' # R
  depends_on 'libva' # R
  depends_on 'libvorbis' # R
  depends_on 'libvpx' # R
  depends_on 'libx264' # R
  depends_on 'libxml2' # R
  depends_on 'mesa' # R
  depends_on 'nasm' => :build
  depends_on 'numactl' # R
  depends_on 'onevpl' # R
  depends_on 'opus' # R
  depends_on 'pango' # R
  depends_on 'rust' => :build
  depends_on 'speex' # R
  depends_on 'util_linux' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'xcb_util' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

  no_lto

  def self.prebuild
    ConvenienceFunctions.libtoolize('freetype')
    ConvenienceFunctions.libtoolize('fribidi')
    ConvenienceFunctions.libtoolize('glib')
    ConvenienceFunctions.libtoolize('harfbuzz')
    ConvenienceFunctions.libtoolize('libpng')
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
    ConvenienceFunctions.libtoolize('libxml2')
  end

  def self.build
    # Need to temporarily create a symlink for libfribidi.la or the build fails
    # with a libtool error.
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libfribidi.la", "#{CREW_PREFIX}/lib/"

    system "LDFLAGS+=' -L #{CREW_LIB_PREFIX}' ./configure #{CREW_CONFIGURE_OPTIONS} \
      --enable-x265 \
      --enable-numa \
      --enable-fdk-aac \
      --enable-qsv \
      --no-harden \
      --force"
    FileUtils.mkdir_p 'build/contrib/lib/pkgconfig'
    Dir.chdir('build/contrib/lib/pkgconfig') do
      @handbrake_libs = %w[glib-2.0 fribidi harfbuzz freetype2]
      @handbrake_libs.each do |f|
        next if File.file?("#{f}.pc")

        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/pkgconfig/#{f}.pc", "#{f}.pc"
      end
    end
    system 'make -C build || make -j1 -C build'

    # Remove temporarily created symlink for libfribidi.la.
    FileUtils.rm_f "#{CREW_PREFIX}/lib/libfribidi.la"
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/HandBrakeCLI", "#{CREW_DEST_PREFIX}/bin/hb"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-handbrake", <<~HANDBRAKE_ENVD_EOF
      alias ghb="GDK_BACKEND=wayland ghb"
    HANDBRAKE_ENVD_EOF
  end

  def self.postinstall
    ExitMessage.add <<~EOT1.lightblue
      To get started, type 'ghb'.
      Type 'hb' for the command line.
    EOT1
  end
end
