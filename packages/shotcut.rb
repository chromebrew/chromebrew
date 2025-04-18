require 'package'

class Shotcut < Package
  description 'Shotcut is a free, open source, cross-platform video editor.'
  homepage 'https://www.shotcut.org/'
  version '24.04.28'
  license 'GPL-3+'
  compatibility 'x86_64'
  min_glibc '2.30'
  source_url 'https://github.com/mltframework/shotcut/releases/download/v24.04.28/shotcut-linux-x86_64-240428.txz'
  source_sha256 'eaf2aadc646fdf34fb5b2b0e3eef200a95aab72d23d2b7210849f43249c8d2ce'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '0394e872c8c1302ebd28f740087bdde1fbf74cc11fb89c5a7f2680f49c36dabb'
  })

  depends_on 'acl' # R
  depends_on 'alsa_lib' # R
  depends_on 'bzip2' # R
  depends_on 'dav1d' # R
  depends_on 'dbus' # R
  depends_on 'elfutils' # R
  depends_on 'eudev' # R
  depends_on 'expat' # R
  depends_on 'fftw' # R
  depends_on 'flac' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3'
  depends_on 'harfbuzz' # R
  depends_on 'jack' # R
  depends_on 'libaom' # R
  depends_on 'libarchive' # R
  depends_on 'libbsd' # R
  depends_on 'libdb' # R
  depends_on 'libdrm' # R
  depends_on 'libepoxy' # R
  depends_on 'libgcrypt' # R
  depends_on 'libglvnd' # R
  depends_on 'libgpg_error' # R
  depends_on 'libice' # R
  depends_on 'libinput' # R
  depends_on 'libmp3lame' # R
  depends_on 'libogg' # R
  depends_on 'libpciaccess' # R
  depends_on 'libpng' # R
  depends_on 'libsamplerate' # R
  depends_on 'libsdl2' # R
  depends_on 'libsm' # R
  depends_on 'libsndfile' # R
  depends_on 'libtheora' # R
  depends_on 'libva' # R
  depends_on 'libvorbis' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libx264' # R
  depends_on 'libxcb' # R
  depends_on 'libxcursor' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxinerama' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxml2' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'libxshmfence' # R
  depends_on 'libxss' # R
  depends_on 'libxv' # R
  depends_on 'libxxf86vm' # R
  depends_on 'lz4' # R
  depends_on 'mtdev' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'opus' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'readline' # R
  depends_on 'rubberband' # R
  depends_on 'sommelier' # L
  depends_on 'sqlite' # R
  depends_on 'tcpwrappers' # R
  depends_on 'util_linux' # R
  depends_on 'vmaf' # R
  depends_on 'wayland' # R
  depends_on 'xcb_util' # R
  depends_on 'xzutils' # R
  depends_on 'zimg' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  def self.build
    File.write 'shotcut', <<~EOF
      #!/bin/sh
      # Set up environment
      # Run this instead of trying to run bin/shotcut. It runs shotcut with the correct environment.
      CURRENT_DIR=$(readlink -f "$0")
      INSTALL_DIR=#{CREW_PREFIX}/share/shotcut
      export LD_LIBRARY_PATH="$INSTALL_DIR/lib":$LD_LIBRARY_PATH
      export MLT_REPOSITORY="$INSTALL_DIR/lib/mlt"
      export MLT_DATA="$INSTALL_DIR/share/mlt"
      export MLT_PROFILES_PATH="$INSTALL_DIR/share/mlt/profiles"
      export MLT_MOVIT_PATH="$INSTALL_DIR/share/movit"
      export FREI0R_PATH="$INSTALL_DIR/lib/frei0r-1"
      # Temporarily ignore user and default path because csladspa bug is crashing with
      # LADSPA_PATH set, and Shotcut only needs the supplied SWH plugins.
      # export LADSPA_PATH="$LADSPA_PATH:/usr/local/lib/ladspa:/usr/lib/ladspa:/usr/lib64/ladspa:$INSTALL_DIR/lib/ladspa"
      export LADSPA_PATH="$INSTALL_DIR/lib/ladspa"
      export LIBVA_DRIVERS_PATH="$INSTALL_DIR/lib/va"
      cd "$INSTALL_DIR"
      export QT_PLUGIN_PATH="lib/qt5"
      export QML2_IMPORT_PATH="lib/qml"
      bin/shotcut "$@"
    EOF
  end

  def self.install
    Dir.chdir 'Shotcut.app' do
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/shotcut"
      FileUtils.mv 'bin', "#{CREW_DEST_PREFIX}/share/shotcut"
      FileUtils.mv 'lib', "#{CREW_DEST_PREFIX}/share/shotcut"
      FileUtils.mv 'share/applications', "#{CREW_DEST_PREFIX}/share"
      FileUtils.mv 'share/icons', "#{CREW_DEST_PREFIX}/share"
      FileUtils.mv 'share', "#{CREW_DEST_PREFIX}/share/shotcut"
    end
    FileUtils.install 'shotcut', "#{CREW_DEST_PREFIX}/bin/shotcut", mode: 0o755
  end
end
