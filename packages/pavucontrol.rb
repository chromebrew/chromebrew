require 'package'

class Pavucontrol < Package
  description 'PulseAudio Volume Control'
  homepage 'https://freedesktop.org/software/pulseaudio/pavucontrol/'
  @_ver = '4.0'
  version "#{@_ver}-381b-1"
  compatibility 'all'
  source_url 'https://github.com/pulseaudio/pavucontrol/archive/381b708202e87e40347a57f8a627014199cde266.zip'
  source_sha256 'aa6c5814e77a8f36d8ed50b70381fbfbab2ebbf0fb62548ec8b8b935527d527e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-381b-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-381b-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-381b-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pavucontrol-4.0-381b-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2773e569e8fef5cbc3d2adadf9d94abdbb7122393baff840e6f743ebe669f1b9',
     armv7l: '2773e569e8fef5cbc3d2adadf9d94abdbb7122393baff840e6f743ebe669f1b9',
       i686: '7854e1bc1d712dff60a60e91fdaeaf29ddc11cb558245e91aaebdb10cf9893bc',
     x86_64: '01f0d27fac88490d8d4b149a3396e8e0fd85e2c5763a08f4367245e10b6ea303'
  })

  depends_on 'libcanberra'
  depends_on 'gtkmm3'
  depends_on 'libsigcplusplus'
  depends_on 'pulseaudio'
  depends_on 'pygtk'
  depends_on 'glibmm'

  def self.build
    system 'NOCONFIGURE=1 ./bootstrap.sh'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
    ./configure \
    #{CREW_OPTIONS} \
    --disable-lynx"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
