require 'package'

class Py3_flask < Package
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  @_ver = '2.0.2'
  version "#{@_ver}-1"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/flask.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/2.0.2-1_armv7l/py3_flask-2.0.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/2.0.2-1_armv7l/py3_flask-2.0.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/2.0.2-1_i686/py3_flask-2.0.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flask/2.0.2-1_x86_64/py3_flask-2.0.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0a83dc2e0183810bd3e2687a4ad4013e55e366792833278b0249146d2ca44772',
     armv7l: '0a83dc2e0183810bd3e2687a4ad4013e55e366792833278b0249146d2ca44772',
       i686: '25933700a347244b2aea611b241b245a0ed0ba6ca65180262d0d17faba64136d',
     x86_64: '51565d6e4bef50d572de2bc5b88a18ecaa3501e97e373a5fc91f9b1ce0656ffb'
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
