require 'package'

class Py3_filelock < Package
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  @_ver = '3.0.12'
  version @_ver
  license 'Unlicense'
  compatibility 'all'
  source_url 'https://github.com/benediktschmitt/py-filelock.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.0.12_armv7l/py3_filelock-3.0.12-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.0.12_armv7l/py3_filelock-3.0.12-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_filelock/3.0.12_x86_64/py3_filelock-3.0.12-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '67648c5c3a5bb64e28cb3bf7a86db2b825ae648444975f198ca6c3e9a8471774',
     armv7l: '67648c5c3a5bb64e28cb3bf7a86db2b825ae648444975f198ca6c3e9a8471774',
     x86_64: '265ec94c08c1bb9fa4e49e1b5a5c4a3ff432a55af850f4891b731fab7505c61e'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
