require 'package'

class Dconf_editor < Package
  description 'A graphical viewer and editor of applications internal settings.'
  homepage 'https://wiki.gnome.org/Apps/DconfEditor'
  version '3.38.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/dconf-editor/3.38/dconf-editor-3.38.2.tar.xz'
  source_sha256 '1253dad87e6213fbf313ff9ec9dc4358aa1b10261f28072c1dc0e0997b92f835'

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
