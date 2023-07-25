require 'package'

class Mpv < Package
  description 'Video player based on MPlayer/mplayer2'
  homepage 'https://mpv.io/'
  version '0.36.0'
  license 'LGPL-2.1+, GPL-2+, BSD, ISC and GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/mpv-player/mpv.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpv/0.36.0_armv7l/mpv-0.36.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpv/0.36.0_armv7l/mpv-0.36.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpv/0.36.0_x86_64/mpv-0.36.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '979f189c1c79ecee1309813bf38281d1ce6275bf797b61e8cce3dd4af8247da9',
     armv7l: '979f189c1c79ecee1309813bf38281d1ce6275bf797b61e8cce3dd4af8247da9',
     x86_64: '0a81daf8c213437141fd1e3b07904570cb7b1857a4d5e10b4edf72dbda1b40b7'
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
  depends_on 'libdrm' # R
  depends_on 'libdvdnav' # R
  depends_on 'libdvdread' # R
  depends_on 'libglvnd' # R
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
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # L
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L
  depends_on 'zimg' # R
  depends_on 'zlibpkg' # R
  depends_on 'libxpresent' # R

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
    system 'meson configure builddir'
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
