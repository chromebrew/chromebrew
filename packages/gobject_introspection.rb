require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.78.1'
  version "#{@_ver}-py3.12"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.78.1-py3.12_armv7l/gobject_introspection-1.78.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.78.1-py3.12_armv7l/gobject_introspection-1.78.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.78.1-py3.12_i686/gobject_introspection-1.78.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.78.1-py3.12_x86_64/gobject_introspection-1.78.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7df9732cf230e4d4a399e17fc3606405455fc080d1ac9b0e6be2d29049586699',
     armv7l: '7df9732cf230e4d4a399e17fc3606405455fc080d1ac9b0e6be2d29049586699',
       i686: '40ed883c484a17dbe74951ccf779c9dc6a5d3f32c15651b0e6846abcbdb77563',
     x86_64: 'e6b87bce9515b14229711bcd351e98a0b972c42c31fbce7e639303da082aba36'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R
  depends_on 'py3_setuptools' => :build
end
