require 'package'

class Handbrake < Package
  description 'HandBrake is a tool for converting video from nearly any format to a selection of modern, widely supported codecs.'
  homepage 'https://handbrake.fr/'
  version '1.8.0'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/HandBrake/HandBrake.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '8d64386da999ddee0aac087d2b7275062e59cc37acb06a8504ab0290492eb46b'
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
  depends_on 'gstreamer' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'intel_media_sdk'
  depends_on 'jansson' # R
  depends_on 'libass' # R
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
  depends_on 'speex' # R
  depends_on 'util_linux' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland_protocols' => :build
  depends_on 'xcb_util' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  no_lto

  def self.build
    # Need to temporarily create a symlink for libfribidi.la or the build fails
    # with a libtool error.
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libfribidi.la", "#{CREW_PREFIX}/lib/"

    unless Dir.exist? 'x86_64-cros-linux-gnu'
      system "LDFLAGS+=' -L #{CREW_LIB_PREFIX}' ./configure #{CREW_OPTIONS} \
        --enable-x265 \
        --enable-numa \
        --enable-fdk-aac \
        --enable-qsv \
        --no-harden \
        --force"
    end
    FileUtils.mkdir_p 'x86_64-cros-linux-gnu/contrib/lib/pkgconfig'
    Dir.chdir('x86_64-cros-linux-gnu/contrib/lib/pkgconfig') do
      @handbrake_libs = %w[glib-2.0 fribidi harfbuzz freetype2]
      @handbrake_libs.each do |f|
        next if File.file?("#{f}.pc")

        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/pkgconfig/#{f}.pc", "#{f}.pc"
      end
    end
    system 'make -C x86_64-cros-linux-gnu || make -j1 -C x86_64-cros-linux-gnu'

    # Remove temporarily created symlink for libfribidi.la.
    FileUtils.rm_f "#{CREW_PREFIX}/lib/libfribidi.la"
  end

  def self.install
    Dir.chdir 'x86_64-cros-linux-gnu' do
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
    ExitMessage.add "\nTo get started, type 'ghb'.\n\nType 'hb' for the command line.\n".lightblue
  end
end
