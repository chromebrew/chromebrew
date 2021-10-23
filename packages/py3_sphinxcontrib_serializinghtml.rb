require 'package'

class Py3_sphinxcontrib_serializinghtml < Package
  description 'sphinxcontrib-serializinghtml is a sphinx extension which outputs "serialized" HTML files (json and pickle).'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.1.5'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-serializinghtml.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.5_armv7l/py3_sphinxcontrib_serializinghtml-1.1.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.5_armv7l/py3_sphinxcontrib_serializinghtml-1.1.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.5_i686/py3_sphinxcontrib_serializinghtml-1.1.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_serializinghtml/1.1.5_x86_64/py3_sphinxcontrib_serializinghtml-1.1.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a31bde7f1c2cc96fe0608e0dad4f66bf97b18ce460609ff3ece111b74e791fbe',
     armv7l: 'a31bde7f1c2cc96fe0608e0dad4f66bf97b18ce460609ff3ece111b74e791fbe',
       i686: '79ed77c6e10c30b89f95c914d4e44cbe3f4677bb33f08b2d1fb78b4439f072b7',
     x86_64: '4ecfb51d9d4d5b1538a601f8ce4e1fa8f1ea050daab12669207f60f3b6ba7092'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
