require 'package'

class Py3_sphinxcontrib_applehelp < Package
  description 'sphinxcontrib-applehelp is a sphinx extension which outputs Apple help books.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-applehelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2_armv7l/py3_sphinxcontrib_applehelp-1.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2_armv7l/py3_sphinxcontrib_applehelp-1.0.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_applehelp/1.0.2_x86_64/py3_sphinxcontrib_applehelp-1.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1db60ca36fd42bd589e66962e35c442420ff84b5b1dc3ddd45655c31add61e2a',
     armv7l: '1db60ca36fd42bd589e66962e35c442420ff84b5b1dc3ddd45655c31add61e2a',
     x86_64: '876096dc0a671b5c77229a67eb9abfa5804aeb3263dfef4119553aafaad279d8'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
