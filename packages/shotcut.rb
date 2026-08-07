require 'package'

class Shotcut < Package
  description 'Shotcut is a free, open source, cross-platform video editor.'
  homepage 'https://www.shotcut.org/'
  version '26.8.1'
  license 'GPL-3+'
  compatibility 'x86_64'
  min_glibc '2.30'
  source_url "https://github.com/mltframework/shotcut/releases/download/v#{version}/shotcut-linux-x86_64-#{version}.txz"
  source_sha256 'c4befab2240964389df6139f00aae0b92949f398fd98083b922f3aabd8b7a844'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'd341979d20ece8b8d972505f3b1c59ed871fb577e67baedaf33c2188045c0a73'
  })

  depends_on 'acl' => :library
  depends_on 'alsa_lib' => :library
  depends_on 'at_spi2_core' => :library
  depends_on 'brotli' => :library
  depends_on 'bzip2' => :library
  depends_on 'cairo' => :library
  depends_on 'dav1d' => :library
  depends_on 'dbus' => :library
  depends_on 'e2fsprogs' => :library
  depends_on 'elfutils' => :library
  depends_on 'eudev' => :library
  depends_on 'expat' => :library
  depends_on 'fftw' => :library
  depends_on 'filecmd' => :library
  depends_on 'flac' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'fribidi' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'jack' => :library
  depends_on 'jbigkit' => :library
  depends_on 'keyutils' => :library
  depends_on 'krb5' => :library
  depends_on 'libaom' => :library
  depends_on 'libarchive' => :library
  depends_on 'libbsd' => :library
  depends_on 'libcap' => :library
  depends_on 'libdb' => :library
  depends_on 'libdecor' => :library
  depends_on 'libdeflate' => :library
  depends_on 'libdrm' => :library
  depends_on 'libepoxy' => :library
  depends_on 'libevdev' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libgpg_error' => :library
  depends_on 'libgudev' => :library
  depends_on 'libice' => :library
  depends_on 'libinput' => :library
  depends_on 'libmd' => :library
  depends_on 'libmp3lame' => :library
  depends_on 'libogg' => :library
  depends_on 'libpciaccess' => :library
  depends_on 'libpng' => :library
  depends_on 'libsamplerate' => :library
  depends_on 'libsm' => :library
  depends_on 'libsndfile' => :library
  depends_on 'libtheora' => :library
  depends_on 'libtool' => :library
  depends_on 'libva' => :library
  depends_on 'libvorbis' => :library
  depends_on 'libwacom' => :library
  depends_on 'libwebp' => :library
  depends_on 'libx11' => :library
  depends_on 'libx264' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxcomposite' => :library
  depends_on 'libxcursor' => :library
  depends_on 'libxdamage' => :library
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :library
  depends_on 'libxi' => :library
  depends_on 'libxinerama' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxrandr' => :library
  depends_on 'libxrender' => :library
  depends_on 'libxshmfence' => :library
  depends_on 'libxss' => :library
  depends_on 'libxv' => :library
  depends_on 'libxxf86vm' => :library
  depends_on 'lilv' => :library
  depends_on 'lz4' => :library
  depends_on 'mesa' => :library
  depends_on 'mlt' => :library
  depends_on 'mtdev' => :library
  depends_on 'ncurses' => :library
  depends_on 'openblas' => :library
  depends_on 'openssl' => :library
  depends_on 'opus' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'pipewire' => :library
  depends_on 'pulseaudio' => :library
  depends_on 'readline' => :library
  depends_on 'rubberband' => :library
  depends_on 'sdl2' => :library
  depends_on 'sdl2_compat' => :library
  depends_on 'serd' => :library
  depends_on 'sommelier' => :logical
  depends_on 'sord' => :library
  depends_on 'sqlite' => :library
  depends_on 'sratom' => :library
  depends_on 'tcpwrappers' => :library
  depends_on 'util_linux' => :library
  depends_on 'vidstab' => :library
  depends_on 'vmaf' => :library
  depends_on 'vulkan_icd_loader' => :library
  depends_on 'wayland' => :library
  depends_on 'xcb_util' => :library
  depends_on 'xcb_util_cursor' => :library
  depends_on 'xcb_util_image' => :library
  depends_on 'xcb_util_keysyms' => :library
  depends_on 'xcb_util_renderutil' => :library
  depends_on 'xcb_util_wm' => :library
  depends_on 'xzutils' => :library
  depends_on 'zimg' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  def self.preflight
    # Need at least 320 mb of free disk space to install.
    MiscFunctions.check_free_disk_space(335544320)
  end

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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/shotcut"
    FileUtils.mv 'bin', "#{CREW_DEST_PREFIX}/share/shotcut"
    FileUtils.mv 'lib', "#{CREW_DEST_PREFIX}/share/shotcut"
    FileUtils.mv 'share/applications', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'share/icons', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'share', "#{CREW_DEST_PREFIX}/share/shotcut"
    FileUtils.install 'shotcut', "#{CREW_DEST_PREFIX}/bin/shotcut", mode: 0o755
  end
end
