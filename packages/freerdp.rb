require 'package'

class Freerdp < Package
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version '2.10.0-2a72946'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/FreeRDP/FreeRDP.git'
  git_hashtag '2a72946d18d813daffa574b26c686c3df479a447'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.10.0-2a72946_armv7l/freerdp-2.10.0-2a72946-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.10.0-2a72946_armv7l/freerdp-2.10.0-2a72946-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.10.0-2a72946_x86_64/freerdp-2.10.0-2a72946-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '59532eb9a6cbc636926b798088d83b54ab7054a5f93686658378e8fdc031ac41',
     armv7l: '59532eb9a6cbc636926b798088d83b54ab7054a5f93686658378e8fdc031ac41',
     x86_64: '4e61c5d31c9a17b97b0df22310c35bf2c28faba67556c2f94cd53519aebd9e5f'
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
  depends_on 'gcc_lib' # R
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
        -DCMAKE_SKIP_INSTALL_RPATH=ON \
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
        -DWITH_OPENH264=ON \
        -DWITH_PULSE=ON \
        -DWITH_SERVER=ON \
        -DWITH_SOXR=ON \
        -DWITH_SWSCALE=ON \
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
