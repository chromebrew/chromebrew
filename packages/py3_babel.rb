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
    aarch64: 'b77c680b2c5b2c76e2bca308fa5c1050c87161a8019d923724b924ab9595aae0',
     armv7l: 'b77c680b2c5b2c76e2bca308fa5c1050c87161a8019d923724b924ab9595aae0',
       i686: '5e9efc6f22bef10e2b948d56c278a100c6fc462b57c084598add938f7dd056b0',
     x86_64: '79a4015d2c3730fa8ba3d8eb45e138b8b6f47c46a185a37a786fd7a09fd037a4'
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
