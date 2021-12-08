require 'package'

class Py3_sphinxcontrib_qthelp < Package
  description 'sphinxcontrib-qthelp is a sphinx extension which outputs QtHelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.3'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-qthelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3-1_armv7l/py3_sphinxcontrib_qthelp-1.0.3-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3-1_armv7l/py3_sphinxcontrib_qthelp-1.0.3-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3-1_i686/py3_sphinxcontrib_qthelp-1.0.3-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3-1_x86_64/py3_sphinxcontrib_qthelp-1.0.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c086c15f52ccc6b899a827165e17be82d47681128d545c7b0075f7effcc97232',
     armv7l: 'c086c15f52ccc6b899a827165e17be82d47681128d545c7b0075f7effcc97232',
       i686: '446b44efbe9d17cbc13afdee3c8432364e5a6d1b0230e85957b5ed2b587a22de',
     x86_64: '247ceceff0e00e6f08e745e88b412ebc354ce1815bdc46d641b5c83cd65a7cfa'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
