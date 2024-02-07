require 'buildsystems/meson'

class Mpv < Meson
  description 'Video player based on MPlayer/mplayer2'
  homepage 'https://mpv.io/'
  version '0.37.0'
  license 'LGPL-2.1+, GPL-2+, BSD, ISC and GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.34'
  source_url 'https://github.com/mpv-player/mpv.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb53dfd91a02b33c74b66b336b394aeb04452338db8ac1cfe6b6a2ce7f0cc5a0',
     armv7l: 'cb53dfd91a02b33c74b66b336b394aeb04452338db8ac1cfe6b6a2ce7f0cc5a0',
     x86_64: '312bfa593d69e06fe97aad9bd3ea044f629c762b4403c304285483eec7cd17a1'
  })

  depends_on 'alsa_lib' # R
  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jack' # R
  depends_on 'lcms' # R
  depends_on 'libarchive' # R
  depends_on 'libass' # R
  depends_on 'libbluray' # R
  depends_on 'libcaca' # R
  depends_on 'libcdio_paranoia' # R
  depends_on 'libcdio' # R
  depends_on 'libdovi' => :build
  depends_on 'libdrm' # R
  depends_on 'libdvdnav' # R
  depends_on 'libdvdread' # R
  depends_on 'libglvnd' # R
  depends_on 'libjpeg' # R
  depends_on 'libplacebo' => :build
  depends_on 'libplacebo' # R
  depends_on 'libsdl2' # R
  depends_on 'libva' # R
  depends_on 'libvdpau' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxinerama' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxpresent' # R
  depends_on 'libxrandr' # R
  depends_on 'libxss' # R
  depends_on 'libxv' # R
  depends_on 'luajit' # R
  depends_on 'mesa' # R
  depends_on 'mujs' # R
  depends_on 'openmp' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'py3_docutils' => :build
  depends_on 'rubberband' # R
  depends_on 'shaderc' # R
  depends_on 'sommelier' # L
  depends_on 'uchardet' # R
  depends_on 'vapoursynth' => :build
  depends_on 'vapoursynth' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # L
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L
  depends_on 'zimg' # R
  depends_on 'zlibpkg' # R

  def self.build
    # Wayland is disabled because mpv has moved to
    # wl_compositor 4, while ChromeOS still uses
    # the ancient wl_compositor 3.
    system "meson \
      #{CREW_MESON_OPTIONS} \
      -Dwayland=disabled \
      -Dlibmpv=true \
      -Dgl-x11=enabled \
      -Dsdl2=enabled \
      builddir"
    # mpv conf file
    File.write 'mpv.conf', <<~MPVCONF
      hwdec=auto-safe
      hwdec-codecs=all
      fs=yes
    MPVCONF
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.mpv"
    FileUtils.install 'mpv.conf', "#{CREW_DEST_HOME}/.mpv/mpv.conf", mode: 0o644
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
