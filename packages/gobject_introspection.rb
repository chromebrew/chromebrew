require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.74.0'
  version "#{@_ver}-py3.11"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.74.0-py3.11_armv7l/gobject_introspection-1.74.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.74.0-py3.11_armv7l/gobject_introspection-1.74.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.74.0-py3.11_i686/gobject_introspection-1.74.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.74.0-py3.11_x86_64/gobject_introspection-1.74.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f80268d2aa4a64bd4564fb300f04b1e6618bb074ff8d9b777c0a11a62ad26ea2',
     armv7l: 'f80268d2aa4a64bd4564fb300f04b1e6618bb074ff8d9b777c0a11a62ad26ea2',
       i686: '374471d4c306d795c431257531057d42aee57455604ba739f3d753ee203ab4f1',
     x86_64: '8799e7dd4c312185f7b2f2950fe001cbd2c232237f171ac3022d16b1fc2719c0'
  })

  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
