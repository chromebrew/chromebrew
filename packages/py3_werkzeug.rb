require 'package'

class Py3_werkzeug < Package
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  @_ver = '2.0.2'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/werkzeug.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2-py3.11_armv7l/py3_werkzeug-2.0.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2-py3.11_armv7l/py3_werkzeug-2.0.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2-py3.11_i686/py3_werkzeug-2.0.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_werkzeug/2.0.2-py3.11_x86_64/py3_werkzeug-2.0.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ca4dcadb421cf4caa73355c171f680dc755e2e12e4a9262f5b9db24d40688d35',
     armv7l: 'ca4dcadb421cf4caa73355c171f680dc755e2e12e4a9262f5b9db24d40688d35',
       i686: '6ad0909f41dc0c9cebae24973ea0561fd18dfb05c3a8313d8f2b5fd851f5f8e2',
     x86_64: '66253fc22791847c6a75f00c45501b01d2d67651700f8341e67bc3481b22d96b'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
