require 'buildsystems/autotools'

class Vice < Autotools
  description 'Emulates the C64, the C64DTV, the C128, the VIC20, practically all PET models, the PLUS4 and the CBM-II (aka C610/C510).'
  homepage 'https://vice-emu.sourceforge.io/'
  version '3.10'
  license 'GPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/vice-emu/releases/vice-#{version}.tar.gz"
  source_sha256 '8e5bac18cbcb9f192380ad3ef881f8790f5b75c41d7b3da65d831985d864d6d1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '619d46f9935676402631b2270518a1d8720b0d7f9517884bd7143e0e7205914a',
     armv7l: '619d46f9935676402631b2270518a1d8720b0d7f9517884bd7143e0e7205914a',
     x86_64: '3fc2d4b551be04399dba334428e3f5310afca12529d74e5df55782e11eeb5ce5'
  })

  depends_on 'alsa_lib' => :executable
  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'curl' => :executable
  depends_on 'desktop_file_utils' => :executable
  depends_on 'dos2unix' => :build
  depends_on 'flac' => :executable
  depends_on 'fontconfig' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glew' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'icoutils' => :executable
  depends_on 'libbsd' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libevdev' => :executable
  depends_on 'libglu' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libiconv' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libusb' => :executable
  depends_on 'libx11' => :executable
  depends_on 'mpg123' => :executable
  depends_on 'opencbm' => :executable
  depends_on 'pango' => :executable
  depends_on 'pulseaudio' => :executable
  depends_on 'xa' => :build
  depends_on 'xdg_utils' => :logical
  depends_on 'zlib' => :executable

  autotools_configure_options '--enable-gtk3ui \
    --enable-desktop-files \
    --with-flac \
    --with-mpg123'
end
