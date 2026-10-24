require 'buildsystems/pip'

class Py3_dbus_python < Pip
  description 'libdbus language binding (wrapper) for CPython'
  homepage 'https://gitlab.freedesktop.org/dbus/dbus-python'
  version "1.5.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c675d76002a356910f3d69a80448be6176945567a5e14d34bbac9a6bb07ad40',
     armv7l: '6c675d76002a356910f3d69a80448be6176945567a5e14d34bbac9a6bb07ad40',
     x86_64: '8360580cbd937ae635d2e661c40d392a5a2ef98a45de7ceeda7253e4f5a55772'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'dbus' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_meson_python' => :build
  depends_on 'py3_patchelf' => :build
  depends_on 'python3' => :logical

  no_source_build
end
