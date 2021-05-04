require 'package'

class Py3_chardet < Package
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  @_ver = '4.0.0'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/chardet/chardet.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
