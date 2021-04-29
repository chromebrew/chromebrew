require 'package'

class Py3_wheel < Package
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  @_ver = '0.36.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.36.2_armv7l/py3_wheel-0.36.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.36.2_armv7l/py3_wheel-0.36.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.36.2_i686/py3_wheel-0.36.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.36.2_x86_64/py3_wheel-0.36.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '06b0135ace731c342706f307a5c41f52f73a59957be395f9fdf25af89000f77a',
     armv7l: '06b0135ace731c342706f307a5c41f52f73a59957be395f9fdf25af89000f77a',
       i686: '602342af626c62f894bbc133b9cceed7bd8caffb0f9eb655899639714bb3ddc3',
     x86_64: '90da6888403ebdddf46183bc8e25129574e629d69effa868b074e8a8ef84c2ae'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
