require 'package'

class Geoclue < Package
  description 'GeoClue location framework'
  homepage 'https://gitlab.freedesktop.org/geoclue/geoclue'
  version '2.5.3'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/geoclue/geoclue/-/archive/2.5.3/geoclue-2.5.3.tar.bz2'
  source_sha256 'a626f6adaff15d88fd0561344e614e371900e4a64a1fe9ddfcdd40d39712e78b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geoclue-2.5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geoclue-2.5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/geoclue-2.5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geoclue-2.5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9a4e92261cfe8cf57ca41164eb36956cff8f4c7ac1be4e4369939a75a5448a25',
     armv7l: '9a4e92261cfe8cf57ca41164eb36956cff8f4c7ac1be4e4369939a75a5448a25',
       i686: 'c881ab65cd5fc0d0468312d59f521b9c4add00cc79eff2fbda1bcf83610c2b6f',
     x86_64: '38a2a7982d13e84597fb0745800e8204a7ba7a1309e3cce5a5cb30a623926270',
  })

  depends_on 'avahi'
  depends_on 'json_glib'
  depends_on 'libnotify'
  depends_on 'libsoup'
  depends_on 'modemmanager'
  depends_on 'meson' => :build

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --sysconfdir #{CREW_PREFIX}/etc -Ddbus-srv-user=#{USER} -Dgtk-doc=false build"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
