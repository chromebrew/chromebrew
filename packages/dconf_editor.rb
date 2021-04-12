require 'package'

class Dconf_editor < Package
  description 'A graphical viewer and editor of applications internal settings.'
  homepage 'https://wiki.gnome.org/Apps/DconfEditor'
  version '3.38.3'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/dconf-editor/-/archive/#{version}/dconf-editor-#{version}.tar.bz2"
  source_sha256 '558408f2abac1129cd010be17db7df3b976d51206b17df603ee7aae4d0f6dd52'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dconf_editor-3.38.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dconf_editor-3.38.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dconf_editor-3.38.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dconf_editor-3.38.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a54f46627b350bd3af6c5430e1a7d73a8318a33c132802d7898795156cb0f954',
     armv7l: 'a54f46627b350bd3af6c5430e1a7d73a8318a33c132802d7898795156cb0f954',
       i686: '094ab1f041159d42988818c3c4f2386e7839605c1cf542060d95e76d1c5268c8',
     x86_64: '7467194d01f384f5dfcff57e190c5df92bef0e35be0a2fd257bb9255f3683cc4'
  })

  depends_on 'dconf'
  depends_on 'gtk3'
  depends_on 'sommelier'
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
            builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system 'ninja -C builddir test'
  end
  
  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
