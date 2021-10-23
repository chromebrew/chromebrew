require 'package'

class Py3_filelock < Package
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  @_ver = '3.3.0'
  version @_ver
  license 'Unlicense'
  compatibility 'all'
  source_url 'https://github.com/benediktschmitt/py-filelock.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.3.0_armv7l/py3_filelock-3.3.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.3.0_armv7l/py3_filelock-3.3.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.3.0_i686/py3_filelock-3.3.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.3.0_x86_64/py3_filelock-3.3.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '82a0ea0420a6e822d5da2d04c728d2103de813c4bf43e0904504f27d269f1d5e',
     armv7l: '82a0ea0420a6e822d5da2d04c728d2103de813c4bf43e0904504f27d269f1d5e',
       i686: '265536b7fffa3bf070cee5c9c9a779ed7645e76b8ed8b36f481274c419609e53',
     x86_64: 'f846349a79acdc58ecc82bf4d51dec08a5b0fcb31a59b35bb482fa84ed4bfa5c'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
