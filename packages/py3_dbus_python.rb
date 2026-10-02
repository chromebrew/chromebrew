require 'buildsystems/pip'

class Py3_dbus_python < Pip
  description 'libdbus language binding (wrapper) for CPython'
  homepage 'https://gitlab.freedesktop.org/dbus/dbus-python'
  version "1.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11185685473c1768c6d1e7d1ca893f3a010f75ac89868149c8c5c998ea75b72b',
     armv7l: '11185685473c1768c6d1e7d1ca893f3a010f75ac89868149c8c5c998ea75b72b',
     x86_64: '3b0e6a8315964eda835ffbc080b98292dd7c7d409f14adeb2af5827108a7fcae'
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
