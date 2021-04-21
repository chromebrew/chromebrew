require 'package'

class Freerdp < Package
  description 'FreeRDP is a free implementation of the Remote Desktop Protocol.'
  homepage 'https://www.freerdp.com/'
  version '2.3.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/FreeRDP/FreeRDP/archive/refs/tags/#{version}.tar.gz"
  source_sha256 'a1f52f0d9569b418a555ffe4d15a3782712198be47308e9514d20ca5af41a1b1'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/freerdp-2.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/freerdp-2.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/freerdp-2.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/freerdp-2.3.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'dd2db88bb1442ed6d8d37d064ed5701087e339008b91314916b69b0f0f127ca6',
     armv7l: 'dd2db88bb1442ed6d8d37d064ed5701087e339008b91314916b69b0f0f127ca6',
       i686: 'fd935d4def75b22e6ad98c2435c2ccae461c689be480dfe9b7afd49a6fef3798',
     x86_64: '46cf60d78f89cd9adab7d71a8d2d204a0633efef5362eacf8d1085f131bc0eac'
  })

  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'faac'
  depends_on 'faad2'
  depends_on 'ffmpeg'
  depends_on 'gsm'
  depends_on 'gst_plugins_base'
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
