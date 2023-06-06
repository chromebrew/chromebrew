# Adapted from Arch Linux libdecor PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libdecor/trunk/PKGBUILD

require 'package'

class Libdecor < Package
  description 'Client-side decorations library for Wayland clients'
  homepage 'https://gitlab.gnome.org/jadahl/libdecor'
  version '0.1.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/jadahl/libdecor/-/archive/0.1.1/libdecor-0.1.1.tar.gz'
  source_sha256 '82adece5baeb6194292b0d1a91b4b3d10da41115f352a5e6c5844b20b88a0512'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdecor/0.1.1_armv7l/libdecor-0.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdecor/0.1.1_armv7l/libdecor-0.1.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdecor/0.1.1_x86_64/libdecor-0.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '24cc3736d9aba19ac6b3816c443b5b87bba919676d81adeedecac209a881e122',
     armv7l: '24cc3736d9aba19ac6b3816c443b5b87bba919676d81adeedecac209a881e122',
     x86_64: '1a9f8f871d637ae5d0c1df1510478a84a9dbbf71e147b84365637148f503bd4a'
  })

  depends_on 'dbus' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wayland' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dlocalstatedir=#{CREW_PREFIX}/var \
      -Dsharedstatedir=#{CREW_PREFIX}/var/lib \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
