# Adapted from Arch Linux jellyfin-media-player PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=jellyfin-media-player

require 'package'

class Jellyfin_media_player < Package
  description 'Jellyfin Desktop Client'
  homepage 'https://github.com/jellyfin/jellyfin-media-player'
  version '1.9.1'
  license 'GPL'
  compatibility 'x86_64'
  source_url 'https://github.com/jellyfin/jellyfin-media-player/archive/refs/tags/v1.9.1.tar.gz'
  source_sha256 '8d119bb78e897ace3041cf332114a79c51be4d8e0cc8c68f5745fd588c2b9bde'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jellyfin_media_player/1.9.1_x86_64/jellyfin_media_player-1.9.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '36c7847fbc29da687a10369e15819249788fdd72b134bf2850f86e7104d7ad93'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libcec' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libsdl2' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrandr' # R
  depends_on 'minizip' # R
  depends_on 'mpv' # R
  depends_on 'p8_platform' => :build
  depends_on 'protobuf' => :build
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
  depends_on 'qtlocation' # R
  depends_on 'qtquickcontrols' # L
  depends_on 'qtwayland' => :build
  depends_on 'qtwebchannel' # R
  depends_on 'qtwebengine' # R
  depends_on 'qtx11extras' # R
  depends_on 'shaderc' # L
  depends_on 'sommelier' # L
  depends_on 'zlibpkg' # R

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
    File.write 'jellyfinmediaplayer_env.d', <<~JELLYFIN_ENVD_EOF
      # QT_QPA_PLATFORM=wayland is unaccelerated and unusable.
      alias jmp="QT_QPA_PLATFORM=eglfs jellyfinmediaplayer"
    JELLYFIN_ENVD_EOF
    FileUtils.install 'jellyfinmediaplayer_env.d', "#{CREW_DEST_PREFIX}/etc/env.d/10-jellyfinmediaplayer", mode: 0o644
  end

  def self.postinstall
    puts
    puts 'Please run the following to finish the install:'.orange
    puts "source #{CREW_PREFIX}/etc/env.d/10-jellyfinmediaplayer".lightblue
    puts
  end
end
