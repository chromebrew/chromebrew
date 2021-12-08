require 'package'

class Py3_sphinxcontrib_htmlhelp < Package
  description 'sphinxcontrib-htmlhelp is a sphinx extension which renders HTML help files.'
  homepage 'https://www.sphinx-doc.org/'
  @_ver = '2.0.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinxcontrib-htmlhelp.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0_armv7l/py3_sphinxcontrib_htmlhelp-2.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0_armv7l/py3_sphinxcontrib_htmlhelp-2.0.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0_i686/py3_sphinxcontrib_htmlhelp-2.0.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sphinxcontrib_htmlhelp/2.0.0_x86_64/py3_sphinxcontrib_htmlhelp-2.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8d336c7e2108662fcb28dfa4c37bbc4bd14d9f191184806b5d08b4574cb5f6b5',
     armv7l: '8d336c7e2108662fcb28dfa4c37bbc4bd14d9f191184806b5d08b4574cb5f6b5',
       i686: 'ed05c393eb871eaac511196ca67a4b86286f25f629747bcafa8c6f223cd843c8',
     x86_64: 'a1dd589c8c6a04047fcad2e7db5eaa488e448c77fc784e3bbfad6888e50b71a9'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
