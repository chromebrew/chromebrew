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
    aarch64: 'd6368995006799f09dcefcc7e158a2b843d89a405e0fc7882dea212da7beafef',
     armv7l: 'd6368995006799f09dcefcc7e158a2b843d89a405e0fc7882dea212da7beafef',
       i686: 'f7b47f71836fec14ef46cdea862fdefb7857b4ff51e320b9914451535b689254',
     x86_64: 'df54965db5cdf4118a1557bb3935ed62d0d5cfa454490df0cc571257cd5739f5'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
