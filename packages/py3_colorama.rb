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

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
