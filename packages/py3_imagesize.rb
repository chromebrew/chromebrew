require 'package'

class Py3_imagesize < Package
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  @_ver = '1.1.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/shibukawa/imagesize_py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-1_armv7l/py3_imagesize-1.1.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-1_armv7l/py3_imagesize-1.1.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-1_i686/py3_imagesize-1.1.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imagesize/1.1.0-1_x86_64/py3_imagesize-1.1.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0a631ced317c01ce94f0ec4eca3648307b103bcb8be80ef26fc21c168f7aab5b',
     armv7l: '0a631ced317c01ce94f0ec4eca3648307b103bcb8be80ef26fc21c168f7aab5b',
       i686: '5dafc0ff6d92665f34804d420660776726443f6ed8c9329ca4f1e26061148db9',
     x86_64: 'de97f1c9967cbc7257139167652a2e07ee59e7bc826370e553c593b0e495139c'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
