require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.74.0'
  version @_ver.to_s
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.74.0_armv7l/gobject_introspection-1.74.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.74.0_armv7l/gobject_introspection-1.74.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.74.0_i686/gobject_introspection-1.74.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.74.0_x86_64/gobject_introspection-1.74.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e73d05327bde784c6ce36fd07fb25add2add359d536a41d33b5f5c3ec7e10ef2',
     armv7l: 'e73d05327bde784c6ce36fd07fb25add2add359d536a41d33b5f5c3ec7e10ef2',
       i686: '65c36e3f95172f94640649a086862d596addaae078dc1f870b1f4f234fc23b99',
     x86_64: '93f359dc31635cc0516f50595f2f33304d80d01e7d1d118708e4eced734cea3c'
  })

  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
