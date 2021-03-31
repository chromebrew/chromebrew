require 'package'

class Mpv < Package
  description 'Video player based on MPlayer/mplayer2'
  homepage 'https://mpv.io/'
  version '0.33.0'
  license 'LGPL-2.1+, GPL-2+, BSD, ISC and GPL-3+'
  compatibility 'all'
  source_url "https://github.com/mpv-player/mpv/archive/v#{version}.tar.gz"
  source_sha256 'f1b9baf5dc2eeaf376597c28a6281facf6ed98ff3d567e3955c95bf2459520b4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.33.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.33.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.33.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.33.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '834b7660f6c44bc5a52236828f6451e03da7f80ce7dcaef84aa5bf539209a0fb',
     armv7l: '834b7660f6c44bc5a52236828f6451e03da7f80ce7dcaef84aa5bf539209a0fb',
       i686: 'e0bdd8907d0f3673397adcc6d042e878510a6657e347fcc4c30db9bdf40af33d',
     x86_64: 'ae78493b16e21e2c9b8ac6ff794a4a89305f9f3686392961b4277bcd5175d109'
  })

  depends_on 'alsa_lib'
  depends_on 'docutils'
  depends_on 'ffmpeg'
  depends_on 'jack'
  depends_on 'lcms'
  depends_on 'libarchive'
  depends_on 'libass'
  depends_on 'libbluray'
  depends_on 'libcaca'
  depends_on 'libcdio'
  depends_on 'libcdio_paranoia'
  depends_on 'libdrm'
  depends_on 'libdvdnav'
  depends_on 'libdvdread'
  depends_on 'libjpeg'
  depends_on 'libjpeg_turbo'
  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxinerama'
  depends_on 'libxkbcommon'
  depends_on 'libxrandr'
  depends_on 'libxss'
  depends_on 'libxv'
  depends_on 'luajit'
  depends_on 'mesa'
  depends_on 'mujs'
  depends_on 'pipewire'
  depends_on 'pulseaudio'
  depends_on 'rubberband'
  depends_on 'shaderc'
  depends_on 'sommelier'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland'
  depends_on 'xdg_base'
  depends_on 'zimg'

  def self.build
    system 'pip install docutils'
    system './bootstrap.py'
    system "env CFLAGS='-flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto=auto' \
      ./waf \
      configure \
      #{CREW_OPTIONS.sub(/--build=.*/, '')} \
      --confdir=#{CREW_PREFIX}/etc/mpv \
      --enable-cdda \
      --enable-dvdnav \
      --enable-gl-x11 \
      --enable-libarchive \
      --enable-libmpv-shared"
    system './waf'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    system './waf', "--destdir=#{CREW_DEST_DIR}", 'install'
    system 'pip uninstall -y docutils'
  end

  def self.postinstall
    # Use XDG_CONFIG_HOME location for config file stub
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config"
    system "touch #{CREW_PREFIX}/.config/mpv"
    system "#{CREW_PREFIX}/bin/gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/* || true"
    system "#{CREW_PREFIX}/bin/gtk4-update-icon-cache -ft #{CREW_PREFIX}/share/icons/* || true"
  end
end
