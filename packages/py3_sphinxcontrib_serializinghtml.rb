require 'package'

class Py3_sphinxcontrib_serializinghtml < Package
  description 'sphinxcontrib-serializinghtml is a sphinx extension which outputs "serialized" HTML files (json and pickle).'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.1.4'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-serializinghtml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.4_armv7l/py3_sphinxcontrib_serializinghtml-1.1.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.4_armv7l/py3_sphinxcontrib_serializinghtml-1.1.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.4_i686/py3_sphinxcontrib_serializinghtml-1.1.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.4_x86_64/py3_sphinxcontrib_serializinghtml-1.1.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ec052912c7425f5425a1c76676eed001cad7206634a4eb8c127d30f00895c752',
     armv7l: 'ec052912c7425f5425a1c76676eed001cad7206634a4eb8c127d30f00895c752',
       i686: '14b0617014d93833ee6bd58cebabdcd40c10deb3c60a3b29473a1a66b40aea81',
     x86_64: '71b951db454bf7cf3d0754ba72f17560b5d2f6a7a115569fd17b71a5eb06af8b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
