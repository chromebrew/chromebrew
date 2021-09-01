require 'package'

class Mpv < Package
  description 'Video player based on MPlayer/mplayer2'
  homepage 'https://mpv.io/'
  @_ver = '0.33.1'
  version "#{@_ver}-1"
  license 'LGPL-2.1+, GPL-2+, BSD, ISC and GPL-3+'
  compatibility 'all'
  source_url "https://github.com/mpv-player/mpv/archive/v#{@_ver}.tar.gz"
  source_sha256 '100a116b9f23bdcda3a596e9f26be3a69f166a4f1d00910d1789b6571c46f3a9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpv/0.33.1-1_armv7l/mpv-0.33.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpv/0.33.1-1_armv7l/mpv-0.33.1-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpv/0.33.1-1_x86_64/mpv-0.33.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '22c7f7b0a877a1a22aa1f312be6ca20b3b3f3e67dd350dd829301752cdbc451f',
     armv7l: '22c7f7b0a877a1a22aa1f312be6ca20b3b3f3e67dd350dd829301752cdbc451f',
     x86_64: 'c4642f6da028403f3efcd6e1b0c9382d410fc106663a0ca70e3f4a785f387628'
  })

  depends_on 'py3_docutils' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'alsa_lib' # R
  depends_on 'ffmpeg' # R
  depends_on 'jack' # R
  depends_on 'lcms' # R
  depends_on 'libarchive' # R
  depends_on 'libass' # R
  depends_on 'libbluray' # R
  depends_on 'libcaca' # R
  depends_on 'libcdio_paranoia' # R
  depends_on 'libcdio' # R
  depends_on 'libdrm' # R
  depends_on 'libdvdnav' # R
  depends_on 'libdvdread' # R
  depends_on 'libjpeg' # R
  depends_on 'libsdl2' # R
  depends_on 'libva' # R
  depends_on 'libvdpau' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxinerama' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrandr' # R
  depends_on 'libxss' # R
  depends_on 'libxv' # R
  depends_on 'llvm' # R
  depends_on 'luajit' # R
  depends_on 'mesa' # R
  depends_on 'mujs' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'rubberband' # R
  depends_on 'shaderc' # R
  depends_on 'wayland' # R
  depends_on 'zimg' # R
  depends_on 'xdg_base' # L
  depends_on 'vulkan_icd_loader' # L
  depends_on 'sommelier' # L

  def self.build
    system './bootstrap.py'
    system "#{CREW_ENV_OPTIONS} \
      ./waf \
      configure \
      #{CREW_OPTIONS.sub(/--build=.*/, '')} \
      --confdir=#{CREW_PREFIX}/etc/mpv \
      --enable-cdda \
      --enable-dvdnav \
      --enable-gl-x11 \
      --enable-libarchive \
      --enable-libmpv-shared \
      --enable-sdl2"
    system "./waf -j#{CREW_NPROC}"
    # mpv conf file
    IO.write 'mpv.conf', <<~MPVCONF
      hwdec=auto-safe
      hwdec-codecs=all
      fs=yes
    MPVCONF
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    system './waf', "--destdir=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/mpv"
    FileUtils.install 'mpv.conf', "#{CREW_DEST_PREFIX}/etc/mpv/mpv.conf", mode: 0o644
  end

  def self.postinstall
    # Use XDG_CONFIG_HOME location for config file stub
    # @xdg_config_home = ENV['XDG_CONFIG_HOME']
    # FileUtils.mkdir_p @xdg_config_home
    # system "touch #{@xdg_config_home}/mpv"
    system "#{CREW_PREFIX}/bin/gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/* || true"
    system "#{CREW_PREFIX}/bin/gtk4-update-icon-cache -ft #{CREW_PREFIX}/share/icons/* || true"
  end
end
