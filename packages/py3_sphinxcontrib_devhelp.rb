require 'package'

class Py3_sphinxcontrib_devhelp < Package
  description 'Sphinxcontrib-devhelp is a sphinx extension which outputs a Devhelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.2'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-devhelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_armv7l/py3_sphinxcontrib_devhelp-1.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_armv7l/py3_sphinxcontrib_devhelp-1.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_i686/py3_sphinxcontrib_devhelp-1.0.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_devhelp/1.0.2_x86_64/py3_sphinxcontrib_devhelp-1.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dac0c64018d2773024219781f16dbc2d6f66313159eb805fea7426a942a03f36',
     armv7l: 'dac0c64018d2773024219781f16dbc2d6f66313159eb805fea7426a942a03f36',
       i686: '6c84e7d96a26722635d98ea7200c478b169152ace4d59a286484b947ef018936',
     x86_64: '419c47c6c8b0c1e11ae84f4d9bcc6fe4e7afb8b00da07de21198fafe703a47f5'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
