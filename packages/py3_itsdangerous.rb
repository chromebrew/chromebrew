require 'package'

class Py3_itsdangerous < Package
  description 'ItsDangerous provide various helpers to pass data to untrusted environments and back.'
  homepage 'https://palletsprojects.com/p/itsdangerous/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/itsdangerous.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1-py3.11_armv7l/py3_itsdangerous-2.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1-py3.11_armv7l/py3_itsdangerous-2.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1-py3.11_i686/py3_itsdangerous-2.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_itsdangerous/2.0.1-py3.11_x86_64/py3_itsdangerous-2.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '74ed5411afe6eb809329a3c32420a396d5594351277e8c31ca4189f43c92ebff',
     armv7l: '74ed5411afe6eb809329a3c32420a396d5594351277e8c31ca4189f43c92ebff',
       i686: 'b451a5210e46366bdb295f0f84b5ddd976a45abdaa5a1ca356dd84d2d7146349',
     x86_64: '1999c81d49d2692b484373632fadfda7bd8402317e5595518ca32fe6a38f95d1'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
