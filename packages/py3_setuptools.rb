require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '62.3.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_packaging'

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
