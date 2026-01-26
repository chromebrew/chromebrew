require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.86.3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7321120f8552ffc540fe00a53d0f4cd121bf472fc40a2e42eda777607f9160cf',
     armv7l: '7321120f8552ffc540fe00a53d0f4cd121bf472fc40a2e42eda777607f9160cf',
       i686: '6572ffc9e0eee70ede8ea4d59a3793801ce85da1d6d8bd8d60db3f030be86af0',
     x86_64: '632a5382589ca90bcc2cb7f8023407d603f31a712807c3b01c5252d37c769add'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'gobject_introspection' => :build unless ARCH == 'i686' # L
  depends_on 'libffi' # R
  depends_on 'pcre2' # R
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'util_linux' # R
  depends_on 'zlib' # R

  gnome
  no_strip if %w[aarch64 armv7l].include? ARCH

  meson_options '-Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'
end
