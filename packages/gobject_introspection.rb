require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.75.4'
  version "#{@_ver}-py3.11"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.75.4-py3.11_armv7l/gobject_introspection-1.75.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.75.4-py3.11_armv7l/gobject_introspection-1.75.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.75.4-py3.11_i686/gobject_introspection-1.75.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.75.4-py3.11_x86_64/gobject_introspection-1.75.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1215b4305d9ebef480bb180f3bb82780b52bedc1aaf64336dcf7697bb3926049',
     armv7l: '1215b4305d9ebef480bb180f3bb82780b52bedc1aaf64336dcf7697bb3926049',
       i686: '2cca223f1a1728e1998741311d4330705de1d21672cfd0789989c2e18ad0922c',
     x86_64: '0308f8c7727e1a3c9767bce329f8a11331a8efb32758d76d23370c3f45e3691a'
  })

  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dpython=#{CREW_PREFIX}/bin/python3 \
      builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
