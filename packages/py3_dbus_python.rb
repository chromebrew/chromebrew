require 'buildsystems/pip'

class Py3_dbus_python < Pip
  description 'libdbus language binding (wrapper) for CPython'
  homepage 'https://gitlab.freedesktop.org/dbus/dbus-python'
  @_ver = '1.2.18'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'autoconf_archive' => :build
  depends_on 'python3' => :build
  no_compile_needed
  depends_on 'dbus' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
end
