require 'package'
require 'convenience_functions'

class Handbrake < Package
  description 'HandBrake is a tool for converting video from nearly any format to a selection of modern, widely supported codecs.'
  homepage 'https://handbrake.fr/'
  version '1.11.2'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/HandBrake/HandBrake.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '1d9fdaf5a57b94b81bdd1889922f9fba8f7e094ce5b877939e57828f3ecbcfa2'
  })

  depends_on 'bzip2' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk4' => :executable
  depends_on 'intel_media_sdk' => :executable
  depends_on 'jansson' => :executable
  depends_on 'libass' => :executable
  depends_on 'libdrm' => :executable
  depends_on 'libdvdcss' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libmp3lame' => :executable
  depends_on 'libogg' => :executable
  depends_on 'libtheora' => :executable
  depends_on 'libva' => :executable
  depends_on 'libvorbis' => :executable
  depends_on 'libvpx' => :executable
  depends_on 'libx264' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'nasm' => :build
  depends_on 'numactl' => :executable
  depends_on 'opus' => :executable
  depends_on 'pango' => :executable
  depends_on 'rust' => :build
  depends_on 'speex' => :executable
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland_protocols' => :build
  depends_on 'xcb_util' => :build
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :executable

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
    ExitMessage.add <<~EOT1
      To get started, type 'ghb'.
      Type 'hb' for the command line.
    EOT1
  end
end
