require 'package'

class Py3_appdirs < Package
  description 'Appdirs is a small Python module for determining appropriate platform-specific directories.'
  homepage 'https://github.com/ActiveState/appdirs/'
  @_ver = '1.4.4'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ActiveState/appdirs.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4_armv7l/py3_appdirs-1.4.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4_armv7l/py3_appdirs-1.4.4-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_appdirs/1.4.4_x86_64/py3_appdirs-1.4.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'db15a8668c1aca1dff9f81cec803d61f1c493527f855aeb86283fe89eceb2997',
     armv7l: 'db15a8668c1aca1dff9f81cec803d61f1c493527f855aeb86283fe89eceb2997',
     x86_64: 'fbf581f687e842e0d1e607ce240d49347e8b7d91cbfb35fe7def1ec56f41c992'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
