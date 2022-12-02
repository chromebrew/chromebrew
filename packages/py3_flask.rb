require 'package'

class Py3_flask < Package
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  @_ver = '2.0.2'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/flask.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/2.0.2-py3.11_armv7l/py3_flask-2.0.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/2.0.2-py3.11_armv7l/py3_flask-2.0.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/2.0.2-py3.11_i686/py3_flask-2.0.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/2.0.2-py3.11_x86_64/py3_flask-2.0.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b9d997f72b3a301b91a836dc20a3ab4109e0342814751897057a78fb0b5f87cf',
     armv7l: 'b9d997f72b3a301b91a836dc20a3ab4109e0342814751897057a78fb0b5f87cf',
       i686: 'd817949cca15b53aa66f64be17f1c174026dca670b449c02f473de2ff0ff5351',
     x86_64: '36fd5bce7e22a23cfff9a342e8daa45acef291c63a7cb4183c381c11893e02ee'
  })

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
