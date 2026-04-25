require 'package'

class Ffmpeg < Package
  description 'Complete solution to record, convert and stream audio and video'
  homepage 'https://ffmpeg.org/'
  version '8.1'
  license 'LGPL-2,1, GPL-2, GPL-3, and LGPL-3' # When changing ffmpeg's configure options, make sure this variable is still accurate.
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.ffmpeg.org/ffmpeg.git'
  git_hashtag "n#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3241f82dacae7ea6ffae1e1941453f178b0dc4e59a70b450a3680127d6a32c4c',
     armv7l: '3241f82dacae7ea6ffae1e1941453f178b0dc4e59a70b450a3680127d6a32c4c',
     x86_64: '8555634b44f0ac4c71a61c2ffd9890acd511300c0b027ae05729a5d0f6da18c9'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'avisynthplus' => :build
  depends_on 'bzip2' => :library
  depends_on 'ccache' => :build
  depends_on 'dav1d' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'gsm' => :build
  depends_on 'gstreamer' => :library
  depends_on 'harfbuzz' # R
  depends_on 'intel_media_sdk' if ARCH == 'x86_64' && CREW_IS_INTEL # R
  depends_on 'jack' => :library
  depends_on 'libaom' => :library
  depends_on 'libass' => :library
  depends_on 'libavc1394' => :library
  depends_on 'libbluray' => :library
  depends_on 'libdc1394' => :build
  depends_on 'libdrm' => :library
  depends_on 'libfdk_aac' => :library
  depends_on 'libfrei0r' => :build
  depends_on 'libglvnd' # R
  depends_on 'libiec61883' => :library
  depends_on 'libjxl' => :library
  depends_on 'libmodplug' => :library
  depends_on 'libmp3lame' => :library
  depends_on 'libopencoreamr' => :library
  depends_on 'libraw1394' => :library
  depends_on 'libsoxr' => :library
  depends_on 'libssh' => :library
  depends_on 'libtheora' => :library
  depends_on 'libva' => :library
  depends_on 'libvdpau' => :library
  depends_on 'libvoamrwbenc' => :build
  depends_on 'libvorbis' => :library
  depends_on 'libvpx' => :library
  depends_on 'libwebp' => :library
  depends_on 'libx11' => :library
  depends_on 'libx264' => :library
  depends_on 'libx265' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxext' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxv' => :library
  depends_on 'libxvid' => :library
  depends_on 'lilv' => :library
  depends_on 'nasm' => :build
  depends_on 'openjpeg' => :library
  depends_on 'openssl' => :library
  depends_on 'opus' => :library
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' => :library
  depends_on 'rav1e' => :library
  depends_on 'rtmpdump' => :library
  depends_on 'rubberband' => :library
  depends_on 'sdl2' => :executable
  depends_on 'sdl2_compat' => :executable
  depends_on 'snappy' => :library
  depends_on 'speex' => :library
  depends_on 'srt' => :library
  depends_on 'tesseract' => :library
  depends_on 'v4l_utils' => :library
  depends_on 'vidstab' => :library
  depends_on 'vmaf' => :library
  depends_on 'xzutils' => :library
  depends_on 'zeromq' => :library
  depends_on 'zimg' => :library
  depends_on 'zlib' => :library
  depends_on 'zvbi' => :library

  no_env_options if %w[aarch64 armv7l].include? ARCH

  def self.patch
    # Needed for qtwebengine compatibility.
    downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/ffmpeg/trunk/add-av_stream_get_first_dts-for-chromium.patch',
               '57e26caced5a1382cb639235f9555fc50e45e7bf8333f7c9ae3d49b3241d3f77'
    system 'patch -Np1 -i add-av_stream_get_first_dts-for-chromium.patch'
  end

  def self.build
    case ARCH
    when 'x86_64'
      @arch_cflags = ''
    when 'aarch64', 'armv7l'
      @arch_cflags = '-mfloat-abi=hard -mthumb -mfpu=neon -march=armv7-a+fp'
    end

    # ChromeOS awk employs sandbox redirection protections which screw
    # up configure script generation, so use mawk.
    system "sed -i 's/awk/mawk/g' configure"
    system "CFLAGS='#{CREW_ENV_OPTIONS_HASH['CFLAGS']} -flto=auto -fuse-ld=#{CREW_LINKER} #{@arch_cflags}' \
      CXXFLAGS='#{CREW_ENV_OPTIONS_HASH['CXXFLAGS']} -flto=auto -fuse-ld=#{CREW_LINKER} #{@arch_cflags}' \
      LDFLAGS='#{CREW_ENV_OPTIONS_HASH['LDFLAGS']} -flto=auto' \
        ./configure \
        --arch=#{ARCH} \
        --disable-debug \
        --disable-doc \
        --disable-iconv \
        --enable-avfilter \
        --enable-avisynth \
        --enable-ffplay \
        --enable-fontconfig \
        --enable-frei0r \
        --enable-gmp \
        --enable-gpl \
        --enable-ladspa \
        --enable-libaom \
        --enable-libass \
        --enable-libbluray \
        --enable-libdav1d \
        --enable-libdrm \
        --enable-libfdk-aac \
        --enable-libfontconfig \
        --enable-libfreetype \
        --enable-libfribidi \
        --enable-libgsm \
        --enable-libiec61883 \
        --enable-libjack \
        --enable-libjxl \
        --enable-libmodplug \
        --enable-libmp3lame \
        --enable-libopencore_amrnb \
        --enable-libopencore_amrwb \
        --enable-libopenjpeg \
        --enable-libopus \
        --enable-libpulse \
        --enable-librav1e \
        --enable-librtmp \
        --enable-librubberband \
        --enable-libsnappy \
        --enable-libsoxr \
        --enable-libspeex \
        --enable-libsrt \
        --enable-libssh \
        --enable-libtesseract \
        --enable-libtheora \
        --enable-libv4l2 \
        --enable-libvidstab \
        --enable-libvmaf \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libwebp \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libxcb \
        --enable-libxml2 \
        --enable-libxvid \
        --enable-libzimg \
        --enable-libzmq \
        --enable-libzvbi \
        --enable-lto \
        --enable-lv2 \
        --enable-lzma \
        --enable-nonfree \
        --enable-opengl \
        --enable-openssl \
        --enable-pthreads \
        --enable-shared \
        --enable-version3 \
        --host-cflags='#{CREW_ENV_OPTIONS_HASH['CFLAGS']} -flto=auto -fuse-ld=#{CREW_LINKER} #{@arch_cflags}' \
        --host-ldflags='#{CREW_ENV_OPTIONS_HASH['LDFLAGS']} -flto=auto' \
        #{CREW_CONFIGURE_OPTIONS.sub(/--build=.*/, '').gsub('vfpv3-d16', 'neon').gsub('--disable-dependency-tracking', '').sub(/--program-prefix.*?(?=\s|$)/, '').sub(/--program-suffix.*?(?=\s|$)/, '')}"
    system "env PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
        make -j#{CREW_NPROC}"
    system 'make tools/qt-faststart'
    system 'make doc/ffmpeg.1'
    system 'make doc/ffplay.1'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'tools/qt-faststart', "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
    FileUtils.install Dir.glob('doc/ff*.1'), "#{CREW_DEST_MAN_PREFIX}/man1/", mode: 0o644
  end
end
