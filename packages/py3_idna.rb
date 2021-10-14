require 'package'

class Py3_idna < Package
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  @_ver = '3.3'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/kjd/idna.git'
  git_hashtag "v#{@_ver}"

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
