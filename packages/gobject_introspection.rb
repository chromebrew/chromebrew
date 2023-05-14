require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.76.1'
  version "#{@_ver}-py3.11"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.76.1-py3.11_armv7l/gobject_introspection-1.76.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.76.1-py3.11_armv7l/gobject_introspection-1.76.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.76.1-py3.11_i686/gobject_introspection-1.76.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.76.1-py3.11_x86_64/gobject_introspection-1.76.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '13be7fdeaadb22165898a210f3e1b3d322b692ebd7722e01077f23002f18956c',
     armv7l: '13be7fdeaadb22165898a210f3e1b3d322b692ebd7722e01077f23002f18956c',
       i686: 'b147bbf5ec3b308bc24da53ca513fce85bd9f468d81122d5c76ed908d907dcce',
     x86_64: 'b24b481077a0573ca0c74944782716c9666b666abac80d96c6068295fc678faa'
  })

  depends_on 'gcc' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R

  gnome

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Dpython=#{CREW_PREFIX}/bin/python3 \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
