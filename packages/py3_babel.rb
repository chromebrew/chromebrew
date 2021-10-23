require 'package'

class Py3_babel < Package
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  @_ver = '2.9.1'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-babel/babel.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1-1_armv7l/py3_babel-2.9.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1-1_armv7l/py3_babel-2.9.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1-1_i686/py3_babel-2.9.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1-1_x86_64/py3_babel-2.9.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2ef366b598ffc715d9715759c4bdf31df2fcd683dc82c0abaa3fce4cde93b0f0',
     armv7l: '2ef366b598ffc715d9715759c4bdf31df2fcd683dc82c0abaa3fce4cde93b0f0',
       i686: '1e3ef455173d3238d08c5a440f998c95712c405c15d5524977a1cd8da00b5b76',
     x86_64: 'e0f6a027e6e07c39e064e7b05c42fa6ffcf2b6218a5abf41c0d2f5c00ffdc145'
  })

  depends_on 'py3_pytz'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
