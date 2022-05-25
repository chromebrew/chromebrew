require 'package'

class Pavucontrol < Package
  description 'PulseAudio Volume Control'
  homepage 'https://freedesktop.org/software/pulseaudio/pavucontrol/'
  version '4.0-381b-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/pulseaudio/pavucontrol/archive/381b708202e87e40347a57f8a627014199cde266.zip'
  source_sha256 'aa6c5814e77a8f36d8ed50b70381fbfbab2ebbf0fb62548ec8b8b935527d527e'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pavucontrol/4.0-381b-1_armv7l/pavucontrol-4.0-381b-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pavucontrol/4.0-381b-1_armv7l/pavucontrol-4.0-381b-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pavucontrol/4.0-381b-1_i686/pavucontrol-4.0-381b-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pavucontrol/4.0-381b-1_x86_64/pavucontrol-4.0-381b-1-chromeos-x86_64.tar.xz'
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
    system "env #{CREW_ENV_OPTIONS} \
    ./configure \
    #{CREW_OPTIONS} \
    --disable-lynx"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
