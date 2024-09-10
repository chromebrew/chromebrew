require 'buildsystems/pip'

class Py3_dbus_python < Pip
  description 'libdbus language binding (wrapper) for CPython'
  homepage 'https://gitlab.freedesktop.org/dbus/dbus-python'
  version '1.3.2-py3.12'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5e966d8f3bca048f10b31c74006cd01da541b7428ef5a29a177fb39b1b80db2',
     armv7l: 'd5e966d8f3bca048f10b31c74006cd01da541b7428ef5a29a177fb39b1b80db2',
     x86_64: '73375d99f12404815763e757e6eeb4871a449133e23ceae03589430fa62c623b'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'dbus' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'py3_meson_python' => :build
  depends_on 'py3_patchelf' => :build
  depends_on 'python3' => :build

  no_source_build
end
