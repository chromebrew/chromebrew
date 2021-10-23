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
    aarch64: '24149db98ea1a926bb6c0a845139ee236b0b5ff3a58ce80103e5cde769b05a2a',
     armv7l: '24149db98ea1a926bb6c0a845139ee236b0b5ff3a58ce80103e5cde769b05a2a',
       i686: '2bc17ba99274765dbfb024a3a85a7c4a497a6e29aaad33a3573e9a57ff9d772e',
     x86_64: '1b063108fac86cc2783d40be672f4f3adecbb2e809873d30d8fbd12d12d1c869'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
