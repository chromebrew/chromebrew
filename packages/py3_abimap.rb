require 'package'

class Py3_abimap < Package
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  @_ver = '0.3.2'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ansasaki/abimap.git'
  git_hashtag "v#{@_ver}"

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
