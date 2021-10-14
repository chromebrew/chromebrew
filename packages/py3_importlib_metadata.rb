require 'package'

class Py3_importlib_metadata < Package
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  @_ver = '4.8.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/python/importlib_metadata.git'
  git_hashtag "v#{@_ver}"

  depends_on 'py3_zipp'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
