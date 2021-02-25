require 'package'

class Clutter_gtk < Package
  description 'The Clutter Gtk package is a library providing facilities to integrate Clutter into GTK+ applications.'
  homepage 'https://wiki.gnome.org/Projects/Clutter'
  compatibility 'all'
  @_app = 'clutter-gtk'
  @_ver = '1.8'
  @_patch = '.4'
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_ver}/#{@_app}-#{@_ver}#{@_patch}"
  version @_ver + @_patch
  source_url "#{@_url}.tar.xz"
  source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d ' ' -f1`.chomp
  
  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'clutter'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
