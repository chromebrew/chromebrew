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

  depends_on 'mpv'
  depends_on 'libcec' unless ARCH == 'i686'
  depends_on 'libsdl2'
  depends_on 'p8_platform' unless ARCH == 'i686'
  depends_on 'protobuf'
  depends_on 'qtwebengine'
  depends_on 'qtx11extras'
  depends_on 'qtquickcontrols'

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DLINUX_X11POWER=ON \
        -DQTROOT=./qt \
        -DCMAKE_SKIP_RPATH=1 \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
