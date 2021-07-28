require 'package'

class Py3_sphinxcontrib_jsmath < Package
  description 'sphinxcontrib-jsmath is a sphinx extension which renders display math in HTML via JavaScript.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.1'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-jsmath.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1_armv7l/py3_sphinxcontrib_jsmath-1.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1_armv7l/py3_sphinxcontrib_jsmath-1.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1_i686/py3_sphinxcontrib_jsmath-1.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_jsmath/1.0.1_x86_64/py3_sphinxcontrib_jsmath-1.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd0301393950d06f2dba2849d6e48d11ec90c01faaff2dd8ba3249e67e34a59f1',
     armv7l: 'd0301393950d06f2dba2849d6e48d11ec90c01faaff2dd8ba3249e67e34a59f1',
       i686: '3752fdb5805ed63a0ee31093cae77a73bd53040643e6251a1ce09ebd58c4da2b',
     x86_64: '897b6481bd73eaa64086ed9429131df7e1f03ca82108bd799b4344e2c825367f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
