require 'package'

class Dconf_editor < Package
  description 'A graphical viewer and editor of applications internal settings.'
  homepage 'https://wiki.gnome.org/Apps/DconfEditor'
  version '3.38.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/dconf-editor/3.38/dconf-editor-3.38.2.tar.xz'
  source_sha256 '1253dad87e6213fbf313ff9ec9dc4358aa1b10261f28072c1dc0e0997b92f835'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dconf_editor-3.38.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dconf_editor-3.38.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dconf_editor-3.38.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dconf_editor-3.38.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8bfd917985fb8c86527f8ff364b76c8187e5512871056e9b2ea7c920020284c0',
     armv7l: '8bfd917985fb8c86527f8ff364b76c8187e5512871056e9b2ea7c920020284c0',
       i686: 'b64e5b7c35b406b80f6da0a2f17d2367030f3c32112956b4b08985113cad066a',
     x86_64: 'c830d27b810f93efc7990127f39743b34e9599835832a061a41a6055f1f107f5',
  })

  depends_on 'dconf'
  depends_on 'gtk3'
  depends_on 'sommelier'
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
            builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system "ninja -C builddir test"
  end
end
