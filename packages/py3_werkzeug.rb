require 'package'

class Py3_werkzeug < Package
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  @_ver = '2.0.2'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/werkzeug.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2_armv7l/py3_werkzeug-2.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2_armv7l/py3_werkzeug-2.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2_i686/py3_werkzeug-2.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2_x86_64/py3_werkzeug-2.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0adfcdf965a0e7f6a6b95cb801573028af9b057684ff0efd864c8184187e3c45',
     armv7l: '0adfcdf965a0e7f6a6b95cb801573028af9b057684ff0efd864c8184187e3c45',
       i686: '8909b459642f48165f9cb92c885a885df77dcb4e67085297cf6b5aaac54f0276',
     x86_64: 'adb5a2ce65c60f335eb44e37c7e3e2059e3ed3081da57239c05139276d66319b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
