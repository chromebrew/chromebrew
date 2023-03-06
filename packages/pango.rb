require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  @_ver = '1.50.14'
  version @_ver
  license 'LGPL-2+ and FTL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag @_ver

  depends_on 'cairo'
  depends_on 'fribidi' # Gets built inside install automatically.
  depends_on 'glib'
  depends_on 'gobject_introspection' # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz'
  depends_on 'libx11'
  depends_on 'libxdmcp'
  depends_on 'libxft'
  depends_on 'libxrender'
  depends_on 'xorg_proto' => :build
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dinstall-tests=false \
    -Dcairo=enabled \
    -Dfreetype=enabled \
    -Dfontconfig=enabled \
    -Dlibthai=disabled \
    -Dgtk_doc=false builddir"
    # gtk-doc is set to false because I (@saltedcofii) am not
    # convinced anyone is reading them; it's accessable online anyway
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
