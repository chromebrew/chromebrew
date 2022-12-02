require 'package'

class Py3_appdirs < Package
  description 'Appdirs is a small Python module for determining appropriate platform-specific directories.'
  homepage 'https://github.com/ActiveState/appdirs/'
  @_ver = '1.4.4'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ActiveState/appdirs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-py3.11_armv7l/py3_appdirs-1.4.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-py3.11_armv7l/py3_appdirs-1.4.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-py3.11_i686/py3_appdirs-1.4.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4-py3.11_x86_64/py3_appdirs-1.4.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3d58fa52d24b1664b9e70d7d7287a38a2f9e2a44da2f28612428e7d77eeccc23',
     armv7l: '3d58fa52d24b1664b9e70d7d7287a38a2f9e2a44da2f28612428e7d77eeccc23',
       i686: '3db1ea6afa3b83e6ce3b67a73a0b859db4c1bbef9e1e815d77e8bbd80549e79b',
     x86_64: 'f75c8097c3bd5b119e36b6b4576baf13df3b3e09bc6d8a1044f5af9d0ddefc6b'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
