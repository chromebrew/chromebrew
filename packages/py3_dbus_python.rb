require 'package'

class Py3_dbus_python < Package
  description 'libdbus language binding (wrapper) for CPython'
  homepage 'https://gitlab.freedesktop.org/dbus/dbus-python'
  @_ver = '1.2.18'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/dbus/dbus-python.git'
  git_hashtag "dbus-python-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbus_python/1.2.18-py3.11_armv7l/py3_dbus_python-1.2.18-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbus_python/1.2.18-py3.11_armv7l/py3_dbus_python-1.2.18-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbus_python/1.2.18-py3.11_i686/py3_dbus_python-1.2.18-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbus_python/1.2.18-py3.11_x86_64/py3_dbus_python-1.2.18-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd02784920f615e953fb663e33b728d863f1c992acc8bcfda41dcd0ba72199a70',
     armv7l: 'd02784920f615e953fb663e33b728d863f1c992acc8bcfda41dcd0ba72199a70',
       i686: '93f165c88365a40d792548ae732a1a9bff974974036301c6d8fcb305653322da',
     x86_64: 'fc38250c40a8266f65d1e0ad8d2483b6c7b5b7c9363dedda7c0a41d089a48556'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'python3' => :build
  depends_on 'dbus' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
