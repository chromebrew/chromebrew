# Adapted from Arch Linux jellyfin-media-player PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=jellyfin-media-player

require 'package'

class Jellyfin_media_player < Package
  description 'Jellyfin Desktop Client'
  homepage 'https://github.com/jellyfin/jellyfin-media-player'
  version '1.9.1-1'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.35'
  source_url 'https://github.com/jellyfin/jellyfin-media-player/archive/refs/tags/v1.9.1.tar.gz'
  source_sha256 '8d119bb78e897ace3041cf332114a79c51be4d8e0cc8c68f5745fd588c2b9bde'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9da834f707cb3480a2fbd172e8fb0aeb4e2df02b995e6d1fb2cdcb10212b0c67',
     armv7l: '9da834f707cb3480a2fbd172e8fb0aeb4e2df02b995e6d1fb2cdcb10212b0c67',
     x86_64: '23648b053d15977a5e9e26a6c3e9c2cee544fab65786a8a553d5bec3002fd1d4'
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
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'qt5_location' # R
  depends_on 'qt5_quickcontrols' # L
  depends_on 'qt5_wayland' => :build
  depends_on 'qt5_webchannel' # R
  depends_on 'qt5_webengine' # R
  depends_on 'qt5_x11extras' # R
  depends_on 'shaderc' # L
  depends_on 'sommelier' # L
  depends_on 'zlibpkg' # R

  def self.patch
    system "sed -i 's/gold/#{CREW_LINKER}/g' CMakeModules/CompilerFlags.cmake"
  end

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
