# Adapted from Arch Linux jellyfin-media-player PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=jellyfin-media-player

require 'package'

class Jellyfin_media_player < Package
  description 'Jellyfin Desktop Client'
  homepage 'https://github.com/jellyfin/jellyfin-media-player'
  version '1.9.0'
  license 'GPL'
  compatibility 'x86_64'
  source_url 'https://github.com/jellyfin/jellyfin-media-player/archive/refs/tags/v1.9.0.tar.gz'
  source_sha256 '366aac5a355d9dd435037442e0fff091a85019ea8b27ce6db3f957c8dd54d1ca'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jellyfin_media_player/1.9.0_x86_64/jellyfin_media_player-1.9.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '04f33ba8a02ba9dde7c4a2605fa243d1a569d1f9daadf43c9818bdd9aa853d64'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libcec' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libsdl2' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrandr' # R
  depends_on 'mpv' # R
  depends_on 'p8_platform' # R
  depends_on 'protobuf' => :build
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
  depends_on 'qtlocation' # R
  depends_on 'qtquickcontrols' # L
  depends_on 'qtwayland' # R
  depends_on 'qtwebchannel' # R
  depends_on 'qtwebengine' # R
  depends_on 'qtx11extras' # R
  depends_on 'shaderc' # L
  depends_on 'sommelier' # L

  def self.build
    system './download_webclient.sh'
    system "cmake -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DLINUX_X11POWER=ON \
      -DQTROOT=./qt \
      -DCMAKE_SKIP_RPATH=1 \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-jellyfinmediaplayer", <<~JELLYFIN_ENVD_EOF
      # QT_QPA_PLATFORM=wayland is unaccelerated and unusable.
      alias jellyfinmediaplayer="QT_QPA_PLATFORM=eglfs jellyfinmediaplayer"
    JELLYFIN_ENVD_EOF
  end

  def self.postinstall
    puts
    puts 'Please run the following to finish the install:'.orange
    puts "source #{CREW_PREFIX}/etc/env.d/10-jellyfinmediaplayer".lightblue
    puts
  end
end
