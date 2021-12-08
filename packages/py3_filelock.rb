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
    aarch64: '7d6088fef48ba5adadd43e24a73ceaf006584dfdb632c8e75daf599f4a775e0d',
     armv7l: '7d6088fef48ba5adadd43e24a73ceaf006584dfdb632c8e75daf599f4a775e0d',
       i686: 'b7e5fa67db6efa39b12856dcb96900affc6812c26352453140ad67dc3685583e',
     x86_64: '8d27ed9ed2662cb8fadff1795c881c5e5480fc2720d009f3d070be4b066ab62f'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
