require 'buildsystems/cmake'

class Freerdp < CMake
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version "3.10.2-#{CREW_ICU_VER}"
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/FreeRDP/FreeRDP.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf1f622992031bdd1fcf4e12e43f87297f23c1ef14ef6cdba2b4485cb95a3af6',
     armv7l: 'bf1f622992031bdd1fcf4e12e43f87297f23c1ef14ef6cdba2b4485cb95a3af6',
     x86_64: 'c4dc7b022583a6f288348fac67ba6013e24a17320a5d4256be0287fb4644583d'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'cjson' # R
  depends_on 'cups' # R
  depends_on 'e2fsprogs' # R
  depends_on 'faac' # R
  depends_on 'faad2' # R
  depends_on 'ffmpeg' # R
  depends_on 'fuse3' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gsm' # R
  depends_on 'gstreamer' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'json_c' # R
  depends_on 'krb5' # R
  depends_on 'libbacktrace' => :build
  depends_on 'libfdk_aac' => :build
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libmp3lame' # R
  depends_on 'libsdl2' # R
  depends_on 'libsm' # R
  depends_on 'libsoup' # R
  depends_on 'libsoxr' # R
  depends_on 'libusb' # R
  depends_on 'libx11' # R
  depends_on 'libxcursor' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxinerama' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxkbfile' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'libxtst' # R
  depends_on 'libxv' # R
  depends_on 'linux_pam' # R
  depends_on 'openh264' # R
  depends_on 'openssl' # R
  depends_on 'pango' # R
  depends_on 'pulseaudio' # R
  depends_on 'sdl2_ttf' # R
  depends_on 'sommelier' # L
  depends_on 'uriparser' # R
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'xdg_base' # L
  depends_on 'xmlto' => :build
  depends_on 'xprop' => :build
  depends_on 'zlib' # R

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
