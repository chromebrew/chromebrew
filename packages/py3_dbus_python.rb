require 'package'

class Py3_dbus_python < Package
  description 'libdbus language binding (wrapper) for CPython'
  homepage 'https://gitlab.freedesktop.org/dbus/dbus-python'
  @_ver = '1.2.18'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/dbus/dbus-python.git'
  git_hashtag "dbus-python-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbus_python/1.2.18_armv7l/py3_dbus_python-1.2.18-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbus_python/1.2.18_armv7l/py3_dbus_python-1.2.18-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbus_python/1.2.18_i686/py3_dbus_python-1.2.18-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbus_python/1.2.18_x86_64/py3_dbus_python-1.2.18-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a27b5684646d29eff8f8f394c219e7499bcc38c5d14da2e38a2fb20a5980d90d',
     armv7l: 'a27b5684646d29eff8f8f394c219e7499bcc38c5d14da2e38a2fb20a5980d90d',
       i686: '7f4ed8709baa910b0fb983d3109d87c1252d4dc9ff61f6fa91a4dd230f250dff',
     x86_64: '07902001348df9983ad0eb42d6c6b04abe18cf5e48ba0f039f6629d677353b0d'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
