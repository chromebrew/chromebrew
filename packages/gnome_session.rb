# Adapted from Arch Linux gnome-session PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gnome-session/trunk/PKGBUILD

require 'package'

class Gnome_session < Package
  description 'The GNOME Session Handler'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-session'
  @_ver = '40.beta'
  version @_ver
  compatibility 'x86_64 , aarch64, armv7l'
  source_url "https://gitlab.gnome.org/GNOME/gnome-session/-/archive/#{@_ver}/gnome-session-#{@_ver}.tar.bz2"
  source_sha256 '0dd8c38c29568db6ffbd2a788f12b9e93262296ffd6d4c40fc2a830099d46883'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_session-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_session-40.beta-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_session-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9bdad789a49f45e3574f829455a1d89d71b1cddbfe8d0cb7c6868b892ad5ae98',
     armv7l: '9bdad789a49f45e3574f829455a1d89d71b1cddbfe8d0cb7c6868b892ad5ae98',
     x86_64: 'b2a8ebdb421823febd16ed797e73fe26c33e53d407db2665af166b96015a0f74'
  })

  depends_on 'elogind'
  depends_on 'dconf'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gtk3'
  depends_on 'gnome_desktop'
  depends_on 'mesa' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'libxtrans' => ':build'
  depends_on 'xmlto' => ':build'
  depends_on 'docbook_xsl' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS}\
      -Dsystemd=false \
      -Dsystemd_session=disable \
      -Dsystemd_journal=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
