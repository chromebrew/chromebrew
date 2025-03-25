require 'buildsystems/meson'

class Mpv < Meson
  description 'Video player based on MPlayer/mplayer2'
  homepage 'https://mpv.io/'
  version '0.40.0'
  license 'LGPL-2.1+, GPL-2+, BSD, ISC and GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/mpv-player/mpv.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f27922e81b166afce9df09ea7e2802dd43239d6f3ff5d114ad59c1f0037a5bc8',
     armv7l: 'f27922e81b166afce9df09ea7e2802dd43239d6f3ff5d114ad59c1f0037a5bc8',
     x86_64: 'f4e97ded5f04dc2cebfc3eac812eefeaf870f01be0249e234d67331b7fdf1068'
  })

  depends_on 'alsa_lib' # R
  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glslang' # R
  depends_on 'jack' # R
  depends_on 'lcms' # R
  depends_on 'libarchive' # R
  depends_on 'libass' # R
  depends_on 'libbluray' # R
  depends_on 'libcaca' # R
  depends_on 'libcdio_paranoia' # R
  depends_on 'libcdio' # R
  depends_on 'libdovi' # R
  depends_on 'libdrm' # R
  depends_on 'libdvdnav' # R
  depends_on 'libdvdread' # R
  depends_on 'libglvnd' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libplacebo' # R
  depends_on 'libsamplerate' # R
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
  depends_on 'vapoursynth' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # L
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L
  depends_on 'zimg' # R
  depends_on 'zlib' # R

  # Wayland is disabled because mpv has moved to
  # wl_compositor 4, while ChromeOS still uses
  # the ancient wl_compositor 3.
  meson_options '-Dwayland=disabled \
      -Dlibmpv=true \
      -Dgl-x11=enabled \
      -Dsdl2=enabled'

  meson_build_extras do
    # mpv conf file
    File.write 'mpv.conf', <<~MPVCONF
      hwdec=auto-safe
      hwdec-codecs=all
      fs=yes
    MPVCONF
  end

  meson_install_extras do
    FileUtils.install 'mpv.conf', "#{CREW_DEST_HOME}/.mpv/mpv.conf", mode: 0o644
  end

  def self.postinstall
    # Use XDG_CONFIG_HOME location for config file stub
    # @xdg_config_home = ENV['XDG_CONFIG_HOME']
    # FileUtils.mkdir_p @xdg_config_home
    # system "touch #{@xdg_config_home}/mpv"
    system "#{CREW_PREFIX}/bin/gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/* || true" if File.file?("#{CREW_PREFIX}/bin/gtk-update-icon-cache")
    system "#{CREW_PREFIX}/bin/gtk4-update-icon-cache -ft #{CREW_PREFIX}/share/icons/* || true" if File.file?("#{CREW_PREFIX}/bin/gtk4-update-icon-cache")
  end
end
