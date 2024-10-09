require 'buildsystems/pip'

class Py3_dbus_python < Pip
  description 'libdbus language binding (wrapper) for CPython'
  homepage 'https://gitlab.freedesktop.org/dbus/dbus-python'
  version "1.3.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '37350575f24690386efe4fbfd172665163e2790bb84987922e4b08a47522a455',
     armv7l: '37350575f24690386efe4fbfd172665163e2790bb84987922e4b08a47522a455',
     x86_64: 'af74a5406dab0e5fbeaca54773900765e82a5657a7c2436c4c32cbdebf1aef0b'
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
