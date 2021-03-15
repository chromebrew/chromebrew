require 'package'

class Ffmpeg < Package
  description 'Complete solution to record, convert and stream audio and video'
  homepage 'https://ffmpeg.org/'
  @_ver = '4.3.2'
  version @_ver
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ffmpeg-4.3.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1db43d0c9a06a9b1d5974635aa393a49c98f70d4e5efe2ca9e03711b334e83ea',
     armv7l: '1db43d0c9a06a9b1d5974635aa393a49c98f70d4e5efe2ca9e03711b334e83ea',
       i686: 'b98609042769bcb508cef9c9848a31cb43b0ca69092996fc9542f25834fefe36',
     x86_64: 'b2143b516399e780184f52be821ad40644443d037d30d4e444342e8d1182c34f'
  })

  depends_on 'alsa_lib'
  depends_on 'avisynthplus'
  depends_on 'ccache' => :build
  depends_on 'chromaprint'
  depends_on 'dav1d'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gsm'
  depends_on 'intel_media_sdk' if ARCH == 'x86_64' && `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i.positive? # This provides libmfx for x86_64
  depends_on 'jack'
  depends_on 'ladspa'
  depends_on 'libaom'
  depends_on 'libass'
  depends_on 'libavc1394'
  depends_on 'libbluray'
  depends_on 'libdc1394'
  depends_on 'libdrm'
  depends_on 'libfdk_aac'
  depends_on 'libfrei0r'
  depends_on 'libiec61883'
  depends_on 'libmfx' if ARCH == 'i686' && `grep -c 'GenuineIntel' /proc/cpuinfo`.to_i.positive?
  depends_on 'libmodplug'
  depends_on 'libmp3lame'
  depends_on 'libopencoreamr'
  depends_on 'libopus'
  depends_on 'libraw1394'
  depends_on 'librsvg'
  depends_on 'libsdl2'
  depends_on 'libsoxr'
  depends_on 'libssh'
  depends_on 'libtheora'
  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'libvoamrwbenc'
  depends_on 'libvorbis'
  depends_on 'libvpx'
  depends_on 'libwebp'
  depends_on 'libx11'
  depends_on 'libx264'
  depends_on 'libx265'
  depends_on 'libxcb'
  depends_on 'libxext'
  depends_on 'libxv'
  depends_on 'libxvid'
  depends_on 'nasm' => :build
  depends_on 'openal'
  depends_on 'openjpeg'
  depends_on 'pulseaudio'
  depends_on 'rav1e'
  depends_on 'rubberband'
  depends_on 'snappy'
  depends_on 'speex'
  depends_on 'srt'
  depends_on 'tesseract'
  depends_on 'v4l_utils'
  depends_on 'vidstab'
  depends_on 'vmaf'
  depends_on 'wavpack'
  depends_on 'xorg_lib'
  depends_on 'zeromq'
  depends_on 'zimg'
  depends_on 'zvbi'


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
      # Patch from https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/ffmpeg/trunk/vmaf-model-path.patch
      @vmaf_patch = <<~'VMAF_PATCH_EOF'
        diff --git a/libavfilter/vf_libvmaf.c b/libavfilter/vf_libvmaf.c
        index 249e50c720..9b791e19b1 100644
        --- a/libavfilter/vf_libvmaf.c
        +++ b/libavfilter/vf_libvmaf.c
        @@ -72,7 +72,7 @@ typedef struct LIBVMAFContext {
         #define FLAGS AV_OPT_FLAG_FILTERING_PARAM|AV_OPT_FLAG_VIDEO_PARAM
         
         static const AVOption libvmaf_options[] = {
        -    {"model_path",  "Set the model to be used for computing vmaf.",                     OFFSET(model_path), AV_OPT_TYPE_STRING, {.str="/usr/local/share/model/vmaf_v0.6.1.pkl"}, 0, 1, FLAGS},
        +    {"model_path",  "Set the model to be used for computing vmaf.",                     OFFSET(model_path), AV_OPT_TYPE_STRING, {.str="/usr/share/model/vmaf_v0.6.1.pkl"}, 0, 1, FLAGS},
             {"log_path",  "Set the file path to be used to store logs.",                        OFFSET(log_path), AV_OPT_TYPE_STRING, {.str=NULL}, 0, 1, FLAGS},
             {"log_fmt",  "Set the format of the log (xml or json).",                            OFFSET(log_fmt), AV_OPT_TYPE_STRING, {.str=NULL}, 0, 1, FLAGS},
             {"enable_transform",  "Enables transform for computing vmaf.",                      OFFSET(enable_transform), AV_OPT_TYPE_BOOL, {.i64=0}, 0, 1, FLAGS},
      VMAF_PATCH_EOF
      IO.write('vmaf.patch', @vmaf_patch)
      system 'patch -p1 -i vmaf.patch'
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
      FileUtils.install 'tools/qt-faststart', "#{CREW_DEST_PREFIX}/bin/", mode: 0755
    end
  end
end
