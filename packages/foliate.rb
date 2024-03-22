require 'package'

class Foliate < Package
  description 'A simple and modern GTK eBook reader'
  homepage 'https://johnfactotum.github.io/foliate/'
  version '2.6.4'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/johnfactotum/foliate/archive/2.6.4.tar.gz'
  source_sha256 '4a4381bff6e398f6734e1695da23f1c593ba2a67e463e07021a089ffd0741776'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a3f9b647599d14c483be05cc2cc4cba6e14e0cb73bd65ffed1635968c7e67e4',
     armv7l: '0a3f9b647599d14c483be05cc2cc4cba6e14e0cb73bd65ffed1635968c7e67e4',
     x86_64: 'd1107a7a7eded897f4b19f2f3c0fc34b83720bf2caac5be77865c223b670ccde'
  })

  depends_on 'gettext' => :build
  depends_on 'gjs'
  depends_on 'iso_codes'
  depends_on 'webkit2gtk'
  depends_on 'desktop_file_utils'
  depends_on 'gdk_base'
  depends_on 'sommelier'

  def self.build
    system "meson build #{CREW_MESON_OPTIONS}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/com.github.johnfactotum.Foliate", "#{CREW_DEST_PREFIX}/bin/foliate"
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    puts "\nType 'foliate' to get started.\n".lightblue
  end
end
