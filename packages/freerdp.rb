require 'package'

class Freerdp < Package
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version '2.8.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/FreeRDP/FreeRDP/archive/refs/tags/#{version}.tar.gz"
  source_sha256 '80afdf3fd4304bfc96d4792632660c5fb65ecf5c04c8872cb838a02f4b4cced3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.8.1_armv7l/freerdp-2.8.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.8.1_armv7l/freerdp-2.8.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.8.1_i686/freerdp-2.8.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.8.1_x86_64/freerdp-2.8.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e8537453f7fceeadb69ba1d10ae5aab8d44bd5b7069183ef999d18ab0514d10d',
     armv7l: 'e8537453f7fceeadb69ba1d10ae5aab8d44bd5b7069183ef999d18ab0514d10d',
       i686: '0ed8d10f56766408d686b92d6db7d8f15b8c94d02674169a476491d8d23feee0',
     x86_64: '5162d2198dcd7f39a6361fcd3ba86a18be6beff8a283be512a8bef4179ee1761'
  })

  depends_on 'alsa_lib' # R
  depends_on 'cairo' => :build
  depends_on 'cups' => :build
  depends_on 'e2fsprogs' # R
  depends_on 'faac' => :build
  depends_on 'faad2' => :build
  depends_on 'ffmpeg' => :build
  depends_on 'glibc' # R
  depends_on 'gsm' => :build
  depends_on 'gstreamer' => :build
  depends_on 'krb5' # R
  depends_on 'libfdk_aac' => :build
  depends_on 'libjpeg' # R
  depends_on 'libmp3lame' # R
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
  depends_on 'linux_pam' => :build
  depends_on 'openssl' # R
  depends_on 'pulseaudio' => :build
  depends_on 'sommelier'
  depends_on 'wayland' => :build
  depends_on 'xdg_base'
  depends_on 'xmlto' => :build
  depends_on 'xprop' => :build

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "env GSS_ROOT_FLAVOUR=MIT \
        cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
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
        -DWITH_WAYLAND=ON \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    puts
    puts 'To test this package, try the following command to connect to the Windows server at https://www.secure-od.com/:'.lightblue
    puts 'xfreerdp -g 800x600 -u demo2 -p D3m02014*Test 109.168.97.222'.lightblue
    puts 'If you don\'t have the Sommelier daemon running, you may need to prepend that with "sommelier -X ".'.lightblue
    puts
  end
end
