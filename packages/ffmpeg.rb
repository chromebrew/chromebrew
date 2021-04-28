require 'package'

class Ffmpeg < Package
  description 'Complete solution to record, convert and stream audio and video'
  homepage 'https://ffmpeg.org/'
  @_ver = '4.4'
  version @_ver
  license 'LGPL-2,1, GPL-2, GPL-3, and LGPL-3' # When changing ffmpeg's configure options, make sure this variable is still accurate.
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpeg/4.4_armv7l/ffmpeg-4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpeg/4.4_armv7l/ffmpeg-4.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpeg/4.4_i686/ffmpeg-4.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ffmpeg/4.4_x86_64/ffmpeg-4.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '745e2246e2e0dbe5b4484484d3f2cd5a1c018c998286b3947f0ca90c576da79a',
     armv7l: '745e2246e2e0dbe5b4484484d3f2cd5a1c018c998286b3947f0ca90c576da79a',
       i686: 'c09e49cd35e4a08120cb41f2c0731276e2fdf370939d87d69825705474e0c29d',
     x86_64: '5b5fcfc511a47302007f5408d876ee25bfcde9c63d4c4afb08b48059e0ea8ef1'
  })

  depends_on 'avisynthplus' # ?
  depends_on 'chromaprint' # ?
  depends_on 'ladspa' # ?
  depends_on 'wavpack' # ?
  depends_on 'zvbi' # ?
  depends_on 'ccache' => :build
  depends_on 'libdc1394' => :build
  depends_on 'libfdk_aac' => :build
  depends_on 'libfrei0r' => :build
  depends_on 'libvoamrwbenc' => :build
  depends_on 'nasm' => :build
  depends_on 'alsa_lib' # R
  depends_on 'dav1d' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gsm' # R
  depends_on 'intel_media_sdk' if ARCH == 'x86_64' && `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i.positive? # R
  depends_on 'jack' # R
  depends_on 'libaom' # R
  depends_on 'libass' # R
  depends_on 'libavc1394' # R
  depends_on 'libbluray' # R
  depends_on 'libdrm' # R
  depends_on 'libiec61883' # R
  depends_on 'libmfx' if ARCH == 'i686' && `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i.positive? # R
  depends_on 'libmodplug' # R
  depends_on 'libmp3lame' # R
  depends_on 'libopencoreamr' # R
  depends_on 'libraw1394' # R
  depends_on 'libsdl2' # R
  depends_on 'libsoxr' # R
  depends_on 'libssh' # R
  depends_on 'libtheora' # R
  depends_on 'libva' # R
  depends_on 'libvdpau' # R
  depends_on 'libvorbis' # R
  depends_on 'libvpx' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libx264' # R
  depends_on 'libx265' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxvid' # R
  depends_on 'libxv' # R
  depends_on 'openal' # ?
  depends_on 'openjpeg' # R
  depends_on 'opus' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'rav1e' # R
  depends_on 'rubberband' # R
  depends_on 'snappy' # R
  depends_on 'speex' # R
  depends_on 'srt' # R
  depends_on 'tesseract' # R
  depends_on 'v4l_utils' # R
  depends_on 'vidstab' # R
  depends_on 'vmaf' # R
  depends_on 'zeromq' # R
  depends_on 'zimg' # R

  def self.build
    case ARCH
    when 'i686'
      @mfx = '--enable-libmfx'
      @lto = ''
      @enablelto = ''
    when 'x86_64'
      @mfx = '--enable-libmfx'
      @lto = '-flto'
      @enablelto = '--enable-lto'
    when 'aarch64', 'armv7l'
      @mfx = ''
      @lto = '-flto'
      @enablelto = '--enable-lto'
    end

    @git_dir = 'ffmpeg_git'
    @git_hash = "n#{@_ver}"
    @git_url = 'https://git.ffmpeg.org/ffmpeg.git'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    system "git clone #{@git_url} #{@git_dir}"
    Dir.chdir @git_dir do
      system "git checkout #{@git_hash}"
      system 'git cherry-pick -n 7c59e1b0f285cd7c7b35fcd71f49c5fd52cf9315' # fix build against libsrt 1.4.2
      # ChromeOS awk employs sandbox redirection protections which screw
      # up configure script generation, so use mawk.
      system "sed -i 's/awk/mawk/g' configure"
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto} -fuse-ld=gold' \
        CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto} -fuse-ld=gold' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE #{@lto}' \
        CC=clang CXX=clang++ \
        ./configure \
        --arch=#{ARCH} \
        #{CREW_OPTIONS.sub(/--build=.*/, '')} \
        --disable-debug \
        --enable-avisynth \
        --enable-ffplay \
        --enable-fontconfig \
        --enable-frei0r \
        --enable-gmp \
        --enable-gnutls \
        --enable-gpl \
        --enable-ladspa \
        --enable-libaom \
        --enable-libass \
        --enable-libbluray \
        --enable-libdav1d \
        --enable-libdrm \
        --enable-libfontconfig \
        --enable-libfreetype \
        --enable-libfribidi \
        --enable-libgsm \
        --enable-libiec61883 \
        --enable-libjack \
        #{@mfx}  \
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
        --enable-libzmq \
        --enable-libzimg \
        #{@enablelto} \
        --enable-lzma \
        --enable-nonfree \
        --enable-pthreads \
        --enable-shared \
        --enable-version3 \
        --host-cflags='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto} -fuse-ld=gold' \
        --host-ldflags='-fno-stack-protector -U_FORTIFY_SOURCE #{@lto}'"

      system "env PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
        make"
      system 'make tools/qt-faststart'
      system 'make doc/ffmpeg.1'
      system 'make doc/ffplay.1'
    end
  end

  def self.install
    Dir.chdir @git_dir do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      FileUtils.install 'tools/qt-faststart', "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
    end
  end
end
