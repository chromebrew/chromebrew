require 'package'

class Py3_sphinxcontrib_htmlhelp < Package
  description 'sphinxcontrib-htmlhelp is a sphinx extension which renders HTML help files.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.3'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-htmlhelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/1.0.3_armv7l/py3_sphinxcontrib_htmlhelp-1.0.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/1.0.3_armv7l/py3_sphinxcontrib_htmlhelp-1.0.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/1.0.3_x86_64/py3_sphinxcontrib_htmlhelp-1.0.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '70829b7bc50fd770d86639633f8925c7f0f694c3c20a4d7026f738ae40bb3bff',
     armv7l: '70829b7bc50fd770d86639633f8925c7f0f694c3c20a4d7026f738ae40bb3bff',
     x86_64: '248b002ef01ee172d9408f53f561268e8aa3e6f094157548c825a72827641c84'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
