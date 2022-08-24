require 'package'

class Freerdp < Package
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version '2.8.0'
  license 'Apache-2.0'
  compatibility 'x86_64 armv7l aarch64'
  source_url "https://github.com/FreeRDP/FreeRDP/archive/refs/tags/#{version}.tar.gz"
  source_sha256 '86f1ce8ef71aff73881a48b40d31dda2fc2a94bdbe37e1c1af8447a0e4fa5cc8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.8.0_armv7l/freerdp-2.8.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.8.0_armv7l/freerdp-2.8.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freerdp/2.8.0_x86_64/freerdp-2.8.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9395c3882984fc0155cd2489546b1717d04483583cd517ddddc7ea9bd04f710a',
     armv7l: '9395c3882984fc0155cd2489546b1717d04483583cd517ddddc7ea9bd04f710a',
     x86_64: '87dcb6d9b28405fe2879dd2862de3c06d1c4981cfede0aaec760a14005d25bc0'
  })

  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'faac'
  depends_on 'faad2'
  depends_on 'ffmpeg'
  depends_on 'gsm'
  depends_on 'gstreamer'
  depends_on 'libfdk_aac'
  depends_on 'linux_pam'
  depends_on 'pulseaudio'
  depends_on 'xdg_base'
  depends_on 'xmlto'
  depends_on 'xprop'
  depends_on 'wayland'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'builddir'
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
