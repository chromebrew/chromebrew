# Adapted from Arch Linux jellyfin-media-player PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=jellyfin-media-player

require 'package'

class Jellyfin_media_player < Package
  description 'Jellyfin Desktop Client'
  homepage 'https://github.com/jellyfin/jellyfin-media-player'
  version '1.7.1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/jellyfin/jellyfin-media-player/archive/refs/tags/v1.7.1.tar.gz'
  source_sha256 '5139cf7128673c053fcc5db7158ee696ccfd7623e133a21c9a2377b66a37efb3'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jellyfin_media_player/1.7.1_x86_64/jellyfin_media_player-1.7.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'cc9b3a3d9e518c5c85aca4d4f6b4dbbcb6edf7e648f946f83cb59e5517279b15'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libcec' unless ARCH == 'i686'
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libsdl2' => :build
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrandr' # R
  depends_on 'mpv' => :build
  depends_on 'p8_platform' unless ARCH == 'i686'
  depends_on 'protobuf' => :build
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
  depends_on 'qtlocation' # R
  depends_on 'qtquickcontrols'
  depends_on 'qtwebchannel' # R
  depends_on 'qtwebengine' => :build
  depends_on 'qtx11extras' => :build

  def self.build
    system './download_webclient.sh'
    FileUtils.mkdir_p 'build'
    Dir.chdir 'build' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DLINUX_X11POWER=ON \
        -DQTROOT=./qt \
        -DCMAKE_SKIP_RPATH=1 \
        -Wno-dev \
        .."
    end
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
