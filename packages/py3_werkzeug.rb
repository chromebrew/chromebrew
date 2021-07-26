require 'package'

class Py3_werkzeug < Package
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  @_ver = '1.0.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/werkzeug.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/1.0.1_armv7l/py3_werkzeug-1.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/1.0.1_armv7l/py3_werkzeug-1.0.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/1.0.1_x86_64/py3_werkzeug-1.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8df6835784b65e901c8f8f857a47cfcbef1dfdd28eef30f44ca01ba49a19182a',
     armv7l: '8df6835784b65e901c8f8f857a47cfcbef1dfdd28eef30f44ca01ba49a19182a',
     x86_64: '232433cbf1bcaba259ed5f73551ea5a8d2b4af0a260d1b18154fdec8c6dd3320'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
