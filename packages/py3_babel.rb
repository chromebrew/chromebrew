require 'package'

class Py3_babel < Package
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  @_ver = '2.9.1'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-babel/babel.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1_armv7l/py3_babel-2.9.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1_armv7l/py3_babel-2.9.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.9.1_x86_64/py3_babel-2.9.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a4c30b48576805611efcdf4f4b58b8ee307fb897055cd46e1597c1f6a38a104c',
     armv7l: 'a4c30b48576805611efcdf4f4b58b8ee307fb897055cd46e1597c1f6a38a104c',
     x86_64: '124f044721c89a5ab3f76202c90ca7ccf4d37cacb69088ca8552218a531e740a'
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
