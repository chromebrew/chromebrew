require 'package'

class Py3_appdirs < Package
  description 'Appdirs is a small Python module for determining appropriate platform-specific directories.'
  homepage 'https://github.com/ActiveState/appdirs/'
  @_ver = '1.4.4'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ActiveState/appdirs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-1_armv7l/py3_appdirs-1.4.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-1_armv7l/py3_appdirs-1.4.4-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-1_i686/py3_appdirs-1.4.4-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-1_x86_64/py3_appdirs-1.4.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1d7773c9fadb29828df643d61dad12b6c037a556a2de27ac249e6741d05fc6c7',
     armv7l: '1d7773c9fadb29828df643d61dad12b6c037a556a2de27ac249e6741d05fc6c7',
       i686: '4e884a6637c9ff337286a921f5ca952a26e26275d04459f14fb1f77e7e6395a9',
     x86_64: 'baf4558f08112c4002c2598cb55decfa2cf2d9e63686c3274671bb794db94652'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
