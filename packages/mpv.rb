require 'package'

class Mpv < Package
  description 'Video player based on MPlayer/mplayer2'
  homepage 'https://mpv.io/'
  version '0.33.1'
  license 'LGPL-2.1+, GPL-2+, BSD, ISC and GPL-3+'
  compatibility 'all'
  source_url "https://github.com/mpv-player/mpv/archive/v#{version}.tar.gz"
  source_sha256 '100a116b9f23bdcda3a596e9f26be3a69f166a4f1d00910d1789b6571c46f3a9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.33.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.33.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.33.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.33.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a2ea4b4c758863b540470ed728dbc5d9fc05f778a703bf31f490544cbe618f9b',
     armv7l: 'a2ea4b4c758863b540470ed728dbc5d9fc05f778a703bf31f490544cbe618f9b',
       i686: '71131f716ec3c4cea9d3f94816634472d1fbea090a7e9122078f825d0d2405ab',
     x86_64: '93efe37ca276f8f83a207fe953df0d0efe565cbc1a7291f0b354b7f412508323'
  })

  depends_on 'docutils' => :build
  depends_on 'libcdio' => :build
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
  end

  def self.postinstall
    # Use XDG_CONFIG_HOME location for config file stub
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config"
    system "touch #{CREW_PREFIX}/.config/mpv"
    system "#{CREW_PREFIX}/bin/gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/* || true"
    system "#{CREW_PREFIX}/bin/gtk4-update-icon-cache -ft #{CREW_PREFIX}/share/icons/* || true"
  end
end
