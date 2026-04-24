require 'buildsystems/cmake'

class Freerdp < CMake
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version "3.25.0-#{CREW_ICU_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/FreeRDP/FreeRDP.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39548a8901a1605d737078a45fb35c4d44a954b24d41941d72f2d022c974ce1a',
     armv7l: '39548a8901a1605d737078a45fb35c4d44a954b24d41941d72f2d022c974ce1a',
     x86_64: '2ac1683873fd0f5d948d2c8192b030e820c8244e6209d1bc58e4dd108b90c870'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :library
  depends_on 'cjson' # R
  depends_on 'cups' => :library
  depends_on 'e2fsprogs' => :library
  depends_on 'faac' => :library
  depends_on 'faad2' => :library
  depends_on 'ffmpeg' => :library
  depends_on 'fuse3' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' => :library
  depends_on 'gsm' # R
  depends_on 'gstreamer' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' => :library
  depends_on 'icu4c' => :library
  depends_on 'json_c' => :library
  depends_on 'krb5' => :library
  depends_on 'libbacktrace' => :build
  depends_on 'libbsd' => :library
  depends_on 'libfdk_aac' => :build
  depends_on 'libice' => :library
  depends_on 'libjpeg_turbo' # R
  depends_on 'libmp3lame' => :library
  depends_on 'libsm' => :library
  depends_on 'libsoup' # R
  depends_on 'libsoxr' => :library
  depends_on 'libusb' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcursor' => :executable
  depends_on 'libxdamage' => :library
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :library
  depends_on 'libxi' => :executable
  depends_on 'libxinerama' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'libxkbfile' => :library
  depends_on 'libxrandr' => :executable
  depends_on 'libxrender' => :executable
  depends_on 'libxtst' => :library
  depends_on 'libxv' => :executable
  depends_on 'linux_pam' => :library
  depends_on 'openh264' => :library
  depends_on 'openssl' => :library
  depends_on 'pango' # R
  depends_on 'pulseaudio' => :library
  depends_on 'sdl2' => :executable
  depends_on 'sdl2_compat' => :executable
  depends_on 'sdl2_ttf' => :executable
  depends_on 'sommelier' => :logical
  depends_on 'uriparser' => :library
  depends_on 'wayland' => :library
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'xdg_base' => :logical
  depends_on 'xmlto' => :build
  depends_on 'xprop' => :build
  depends_on 'zlib' => :library

  cmake_options "-DCMAKE_SKIP_INSTALL_RPATH=ON \
        -DDOCBOOKXSL_DIR=#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-1.79.2 \
        -DWITH_CAIRO=ON \
        -DWITH_CHANNELS=ON \
        -DWITH_CLIENT=ON \
        -DWITH_CLIENT_SDL=ON \
        -DWITH_CUPS=ON \
        -DWITH_DSP_FFMPEG=yes \
        -DWITH_FAAC=ON \
        -DWITH_FAAD2=ON \
        -DWITH_GSM=ON \
        -DWITH_GSSAPI=ON \
        -DWITH_JPEG=ON \
        -DWITH_LAME=ON \
        -DWITH_LIBSYSTEMD=OFF \
        -DWITH_MBEDTLS=OFF \
        -DWITH_OPENH264=ON \
        -DWITH_PULSE=ON \
        -DWITH_SERVER=ON \
        -DWITH_SOXR=ON \
        -DWITH_SWSCALE=ON \
        -DUSE_UNWIND=OFF \
        -DWITH_WAYLAND=ON"

  def self.postinstall
    puts
    puts 'To test this package, try the following command to connect to the Windows server at https://www.secure-od.com/:'.lightblue
    puts 'xfreerdp -g 800x600 -u demo2 -p D3m02014*Test 109.168.97.222'.lightblue
    puts 'If you don\'t have the Sommelier daemon running, you may need to prepend that with "sommelier -X ".'.lightblue
    puts
  end
end
