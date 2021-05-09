require 'package'

class Py3_retrying < Package
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  @_ver = '1.3.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/rholder/retrying.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
