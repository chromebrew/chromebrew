require 'package'

class Pavucontrol < Package
  description 'PulseAudio Volume Control'
  homepage 'https://freedesktop.org/software/pulseaudio/pavucontrol/'
  version "4.0-381b"
  compatibility 'all'
  source_url 'https://github.com/pulseaudio/pavucontrol/archive/381b708202e87e40347a57f8a627014199cde266.zip'
  source_sha256 'aa6c5814e77a8f36d8ed50b70381fbfbab2ebbf0fb62548ec8b8b935527d527e'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-381b-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-381b-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-381b-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-381b-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '55d3cc7504a483f9af794daccea92fcd261cbc8f1a4d4332f99c8a28226ea63d',
      armv7l: '55d3cc7504a483f9af794daccea92fcd261cbc8f1a4d4332f99c8a28226ea63d',
        i686: '2cd937784abe38291a6c0fbc7bd4a6e18626909390b4b1d0f460274dc0fce26d',
      x86_64: 'b9ca4e77191fc33eda5a2dc15e9329862c33af5b096bd5c8dc9ebc7778da69ad',
  })


  depends_on 'libcanberra'
  depends_on 'gtkmm3'
  depends_on 'libsigcplusplus'
  depends_on 'pulseaudio'
  depends_on 'pygtk'
  depends_on 'pulseaudio'
  depends_on 'glibmm'

  def self.build
    system 'NOCONFIGURE=1 ./bootstrap.sh'
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
    ./configure \
    #{CREW_OPTIONS} \
    --disable-lynx"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
