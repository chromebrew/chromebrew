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
    aarch64: 'e94cdeb4263913b22b8c1c72f4079f8e11a20d74cae866bdb6d9c5e59f2a1e2f',
     armv7l: 'e94cdeb4263913b22b8c1c72f4079f8e11a20d74cae866bdb6d9c5e59f2a1e2f',
     x86_64: 'ae50be4cea9e44062e682500199c14adc96cab074d11b0f3dfda0068abedbd55'
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
