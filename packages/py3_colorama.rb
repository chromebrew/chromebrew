require 'package'

class Py3_colorama < Package
  description 'Colorama makes ANSI color sequences work on MS Windows.'
  homepage 'https://github.com/tartley/colorama/'
  @_ver = '0.4.4'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/tartley/colorama.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4_armv7l/py3_colorama-0.4.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4_armv7l/py3_colorama-0.4.4-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4_x86_64/py3_colorama-0.4.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '65a9a09e40d7e266238ccfc497f13f7c11e3d656dd3aaeed65a5401c58dc70fe',
     armv7l: '65a9a09e40d7e266238ccfc497f13f7c11e3d656dd3aaeed65a5401c58dc70fe',
     x86_64: 'df9e61f5e16424e6d02a9eececa4fc284c9a9a26e2b268435566a1d542d6f31d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
