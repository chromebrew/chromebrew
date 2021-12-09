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
    aarch64: 'd32b19317a09b89751f407eed7fd7073038c851d29ecee76bc01de210738cdb1',
     armv7l: 'd32b19317a09b89751f407eed7fd7073038c851d29ecee76bc01de210738cdb1',
       i686: '648d6fa278b8305e1c93ab37c17a4475f6a903454527cc7b5cf74a18bcdd5ae4',
     x86_64: 'e70111023d9f064f0c82e6cc74fc1a4046c5578c21ee74c446d6eb8a4b36c47a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
