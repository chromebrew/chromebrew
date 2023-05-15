require 'package'

class Freerdp < Package
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version '3.0.0-a78182c'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/FreeRDP/FreeRDP.git'
  git_hashtag 'a78182c42523489636ae5f2723126a69cccb93de'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/3.0.0-a78182c_armv7l/freerdp-3.0.0-a78182c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/3.0.0-a78182c_armv7l/freerdp-3.0.0-a78182c-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/3.0.0-a78182c_x86_64/freerdp-3.0.0-a78182c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4e0a0b39ed540c8a61b58ba9d58aecfc0fb78472c6f865be09d8690604a48b94',
     armv7l: '4e0a0b39ed540c8a61b58ba9d58aecfc0fb78472c6f865be09d8690604a48b94',
     x86_64: '713d335270842739c1dfcda767a8eeb821dc49dffc7c9b917e1757dd9132754a'
  })

  depends_on 'alsa_lib' # R
  depends_on 'cairo' => :build
  depends_on 'cjson' # R
  depends_on 'cups' # R
  depends_on 'e2fsprogs' # R
  depends_on 'faac' # R
  depends_on 'faad2' # R
  depends_on 'ffmpeg' # R
  depends_on 'fuse3' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'gsm' # R
  depends_on 'gstreamer' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'krb5' # R
  depends_on 'libfdk_aac' => :build
  depends_on 'libjpeg' # R
  depends_on 'libmp3lame' # R
  depends_on 'libsdl2' # R
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
  depends_on 'pulseaudio' # R
  depends_on 'sommelier' # L
  depends_on 'wayland' # R
  depends_on 'xdg_base' # L
  depends_on 'xmlto' => :build
  depends_on 'xprop' => :build

  def self.build
    system "env GSS_ROOT_FLAVOUR=MIT \
        mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DDOCBOOKXSL_DIR=#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-1.79.2 \
        -DWITH_GSM=ON \
        -DWITH_FAAC=ON \
        -DWITH_FAAD2=ON \
        -DWITH_SWSCALE=ON \
        -DWITH_CAIRO=ON \
        -DWITH_LIBSYSTEMD=OFF \
        -DWITH_DSP_FFMPEG=yes \
        -DWITH_CHANNELS=ON \
        -DWITH_SERVER=ON \
        -DWITH_CLIENT=ON \
        -DWITH_GSSAPI=ON \
        -DWITH_PULSE=ON \
        -DWITH_CUPS=ON \
        -DWITH_SOXR=ON \
        -DWITH_LAME=ON \
        -DWITH_JPEG=ON \
        -DWITH_CLIENT_SDL=ON \
        -DWITH_OPENH264=ON \
        -DWITH_WAYLAND=ON \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.postinstall
    puts
    puts 'To test this package, try the following command to connect to the Windows server at https://www.secure-od.com/:'.lightblue
    puts 'xfreerdp -g 800x600 -u demo2 -p D3m02014*Test 109.168.97.222'.lightblue
    puts 'If you don\'t have the Sommelier daemon running, you may need to prepend that with "sommelier -X ".'.lightblue
    puts
  end
end
