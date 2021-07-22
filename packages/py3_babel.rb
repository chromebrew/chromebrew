require 'package'

class Py3_babel < Package
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  @_ver = '2.9.1'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-babel/babel.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_pytz'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
