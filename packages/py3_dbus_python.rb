require 'buildsystems/pip'

class Py3_dbus_python < Pip
  description 'libdbus language binding (wrapper) for CPython'
  homepage 'https://gitlab.freedesktop.org/dbus/dbus-python'
  version "1.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '946a0e778e799367db1ce34c08693b5f0bcb932da11a52988cc0f27d1d4914b4',
     armv7l: '946a0e778e799367db1ce34c08693b5f0bcb932da11a52988cc0f27d1d4914b4',
     x86_64: 'c6994af972bd88afc85e2b6762222bb66582cb97138130baf60655c2f90fd25d'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'dbus' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'py3_meson_python' => :build
  depends_on 'py3_patchelf' => :build
  depends_on 'python3' => :logical

  no_source_build
end
