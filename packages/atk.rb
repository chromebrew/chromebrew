require 'package'

class Atk < Package
  description 'ATK provides the set of accessibility interfaces that are implemented by other toolkits and applications'
  homepage 'https://developer.gnome.org/atk'
  version '2.38.0'
  compatibility 'all'
  license 'LGPL-2+'
  source_url 'https://gitlab.gnome.org/GNOME/atk.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atk/2.38.0_armv7l/atk-2.38.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atk/2.38.0_armv7l/atk-2.38.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atk/2.38.0_i686/atk-2.38.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atk/2.38.0_x86_64/atk-2.38.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f80a8f01834b6fa38b39e89167cae48022df2923294e0c4878d5c6f71cee1e30',
     armv7l: 'f80a8f01834b6fa38b39e89167cae48022df2923294e0c4878d5c6f71cee1e30',
       i686: 'ea99101c13aa53d25f1279de503718c97371b846b4b4fa46a9baf88189455040',
     x86_64: '2753924328d479e845521c4cdd8ab958537c7a1f63107bda44a6937d1d330419'
  })

  depends_on 'gobject_introspection'
  depends_on 'glib' # R
  depends_on 'glibc' # R

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
