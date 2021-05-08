require 'package'

class Py3_imagesize < Package
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  @_ver = '1.1.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/shibukawa/imagesize_py.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
