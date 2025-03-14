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
    aarch64: 'e2aa3b2db48001734bb47c0c5cd189fc1378e39086ef39675dcb3c9a40b9b571',
     armv7l: 'e2aa3b2db48001734bb47c0c5cd189fc1378e39086ef39675dcb3c9a40b9b571',
     x86_64: '742413aabbb7e4cdf2077c243b9b50c4d984d7c22be74f1b55705bf2bb6066a9'
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
