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
    aarch64: 'ff05d4af75f1a1d53f2b029e9002f1e03daa8cecced493dc2342b0e00f9b896b',
     armv7l: 'ff05d4af75f1a1d53f2b029e9002f1e03daa8cecced493dc2342b0e00f9b896b',
       i686: '884a383b1a6c851b0e04bb3e4dfb98609328a24953334160b9e5d438eeacb673',
     x86_64: '4412b56ca38573e82efc5b19916a3ce7ea4cc3bedc0555a6fb358766e63192e2'
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
