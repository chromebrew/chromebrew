require 'package'

class Gtkmm4 < Package
  description 'The Gtkmm3 package provides a C++ interface to GTK+ 3.'
  homepage 'https://www.gtkmm.org/'
  version '4.0.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtkmm/4.0/gtkmm-4.0.1.tar.xz'
  source_sha256 '8973d9bc7848e02cb2051e05f3ee3a4baffe2feb4af4a5487f0e3132eec03884'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm4-4.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm4-4.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm4-4.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm4-4.0.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1d2640f81201631586b082735b8ad82a229ff9502233acc4ed628ba88dd46278',
     armv7l: '1d2640f81201631586b082735b8ad82a229ff9502233acc4ed628ba88dd46278',
       i686: '2672ac3748735b14decae069d71fc25e2e19b298638e422c11c6424a5763bec0',
     x86_64: 'd6b5659e5e00d16442c9368db8c7baf610fb62f43111ed6f6cd93dfb0417fbf1'
  })

  depends_on 'atkmm'
  depends_on 'gtk4'
  depends_on 'pangomm'
  depends_on 'cairomm'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
