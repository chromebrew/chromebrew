require 'package'

class Py3_sphinxcontrib_qthelp < Package
  description 'sphinxcontrib-qthelp is a sphinx extension which outputs QtHelp document.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '1.0.3'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-qthelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3_armv7l/py3_sphinxcontrib_qthelp-1.0.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3_armv7l/py3_sphinxcontrib_qthelp-1.0.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_qthelp/1.0.3_x86_64/py3_sphinxcontrib_qthelp-1.0.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fd704c99d991b7e9d099048386399c027e05885353c422edd014eee98fa60b5b',
     armv7l: 'fd704c99d991b7e9d099048386399c027e05885353c422edd014eee98fa60b5b',
     x86_64: '12409c13d5e5d417bc9efffd558532652824aae63d00a6c0de886694f9804fa4'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
