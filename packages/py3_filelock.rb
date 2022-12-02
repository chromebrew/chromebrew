require 'package'

class Py3_filelock < Package
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  @_ver = '3.3.0'
  version "#{@_ver}-py3.11"
  license 'Unlicense'
  compatibility 'all'
  source_url 'https://github.com/benediktschmitt/py-filelock.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.3.0-py3.11_armv7l/py3_filelock-3.3.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.3.0-py3.11_armv7l/py3_filelock-3.3.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.3.0-py3.11_i686/py3_filelock-3.3.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.3.0-py3.11_x86_64/py3_filelock-3.3.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1a897ad32010859fec771c5effcc7d6e0e32f314ab4232a3d0381b952c3de18e',
     armv7l: '1a897ad32010859fec771c5effcc7d6e0e32f314ab4232a3d0381b952c3de18e',
       i686: '97e15e5e1e587cf70a58a900ec6838676129533fbb414f56e4ed41c60eec84a5',
     x86_64: '90519a0df43254d4bc4410bfeed9bd0b785748dd260ef7541814e2345e91bef1'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
