require 'package'

class Libdv < Package
  description 'The Quasar DV codec libdv is a software codec for DV video'
  homepage 'http://libdv.sourceforge.net/'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/libdv/libdv-1.0.0.tar.gz'
  source_sha256 'a305734033a9c25541a59e8dd1c254409953269ea7c710c39e540bd8853389ba'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdv-1.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdv-1.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdv-1.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdv-1.0.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f86306f6a491fce2a0b18005e8c28aeac074e441fef41d43f60abecd9a09b2e0',
     armv7l: 'f86306f6a491fce2a0b18005e8c28aeac074e441fef41d43f60abecd9a09b2e0',
       i686: '3f55b05602d407a1649ea5771114634fe8b08496f854471050496434ce2807da',
     x86_64: 'd62fb6a0fd56d1b7c056f5cbb9c774c769a435660c0d50b4fa024dddc4f3689d'
  })

  depends_on 'popt'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
