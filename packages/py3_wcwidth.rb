require 'package'

class Py3_wcwidth < Package
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  @_ver = '0.2.5'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jquast/wcwidth.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
