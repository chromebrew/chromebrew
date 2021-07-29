require 'package'

class Py3_flask < Package
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  @_ver = '1.1.2'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/flask.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/1.1.2_armv7l/py3_flask-1.1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/1.1.2_armv7l/py3_flask-1.1.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/1.1.2_x86_64/py3_flask-1.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '61698011f63fd5edc84c44ef79f38f271281fe7b14f599b6fe78967007f0d11e',
     armv7l: '61698011f63fd5edc84c44ef79f38f271281fe7b14f599b6fe78967007f0d11e',
     x86_64: '6d63948aeaf0a00eb948399d301df392a1e73ab67d0209673a24327d296ed1b3'
  })

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
