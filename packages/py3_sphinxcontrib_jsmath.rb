require 'package'

class Py3_sphinxcontrib_jsmath < Package
  description 'sphinxcontrib-jsmath is a sphinx extension which renders display math in HTML via JavaScript.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.1'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-jsmath.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1-1_armv7l/py3_sphinxcontrib_jsmath-1.0.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1-1_armv7l/py3_sphinxcontrib_jsmath-1.0.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1-1_i686/py3_sphinxcontrib_jsmath-1.0.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1-1_x86_64/py3_sphinxcontrib_jsmath-1.0.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'aa6d2940e79a968edf6e6efee2c827e0cff972e8e783833ae704b12cc93eb15c',
     armv7l: 'aa6d2940e79a968edf6e6efee2c827e0cff972e8e783833ae704b12cc93eb15c',
       i686: '1e89c22b7383ccf25aebce08010b35da3870fac23b6f94679e6c94da1d7b0809',
     x86_64: '15321be51c302dcf7d1baf2c9c2831ef8f698a3bececf0d1996b63ff0491c98c'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
