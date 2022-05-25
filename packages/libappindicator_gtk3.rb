# Adapted from Arch Linux libappindicator PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libappindicator/trunk/PKGBUILD

require 'package'

class Libappindicator_gtk3 < Package
  description 'Allow applications to extend a menu via Ayatana indicators in Unity, KDE or Systray'
  homepage 'https://launchpad.net/libappindicator'
  version '12.10.0'
  license 'LGPL2.1 LGPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://launchpad.net/libappindicator/12.10/12.10.0/+download/libappindicator-12.10.0.tar.gz'
  source_sha256 'd5907c1f98084acf28fd19593cb70672caa0ca1cf82d747ba6f4830d4cc3b49f'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libappindicator_gtk3/12.10.0_armv7l/libappindicator_gtk3-12.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libappindicator_gtk3/12.10.0_armv7l/libappindicator_gtk3-12.10.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libappindicator_gtk3/12.10.0_x86_64/libappindicator_gtk3-12.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f85c3830820c464e863a0dda0dd9805aece7ba4c5732ef79ef6d520e9bc83f3b',
     armv7l: 'f85c3830820c464e863a0dda0dd9805aece7ba4c5732ef79ef6d520e9bc83f3b',
     x86_64: 'ffaa20be62a6af48a4aa709721359a7b1728662b3d1a481e4fbc52d91245d7e1'
  })

  depends_on 'dbus_glib'
  depends_on 'gnome_common'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'libindicator_gtk3'
  depends_on 'pygtk'
  depends_on 'vala'
  depends_on 'libdbusmenu_gtk3'

  def self.patch
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "grep -rl Werror . | xargs sed -i 's,-Wall -Werror,-Wall,g'"
    system 'filefix'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS.sub("CFLAGS='", "CFLAGS='-Wno-deprecated-declarations ")} \
    ./configure \
    #{CREW_OPTIONS} \
    --localstatedir=#{CREW_PREFIX}/var \
    --sysconfdir=#{CREW_PREFIX}/etc \
    --with-gtk=3 \
    --disable-mono-test \
    --enable-gtk-doc-html=no \
    --disable-tests"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
