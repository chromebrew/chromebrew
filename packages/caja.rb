# Adapted from Arch Linux caja PKGBUILD at:
# https://github.com/archlinux/svntogit-community/blob/packages/caja/trunk/PKGBUILD

require 'package'

class Caja < Package
  description 'Caja file manager for the MATE desktop'
  homepage 'https://mate-desktop.org'
  @_ver = '1.25.2'
  version @_ver
  compatibility 'all'
  license 'GPL-2+ LGPL-2+'
  source_url "https://pub.mate-desktop.org/releases/#{@_ver.rpartition('.')[0]}/caja-#{@_ver}.tar.xz"
  source_sha256 'a0737ce87b53add2fc68285dbd52a3cf25ace20f0f56503ebe6dd47e7b5cc124'

  depends_on 'exempi'
  depends_on 'gvfs'
  depends_on 'libexif'
  depends_on 'libsm'
  depends_on 'mate_desktop'
  depends_on 'libnotify'
  depends_on 'sommelier'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
                LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS}"
    
    # https://bugzilla.gnome.org/show_bug.cgi?id=656231
    system "sed -i 's/ -shared / -Wl,-O1,--as-needed\\0/g' libtool"
    
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
    
  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end

  def self.check
    system 'make', 'check'
  end
end