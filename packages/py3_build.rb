require 'package'

class Py3_build < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  @_ver = '0.9.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/build.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-py3.11_armv7l/py3_build-0.9.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-py3.11_armv7l/py3_build-0.9.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-py3.11_i686/py3_build-0.9.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-py3.11_x86_64/py3_build-0.9.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9b0448006c3e4f6453bfcae30472f50a4e68848d6ae322dae9b5335c4274cb71',
     armv7l: '9b0448006c3e4f6453bfcae30472f50a4e68848d6ae322dae9b5335c4274cb71',
       i686: '9048410e94aef4feb6950fa7574c0082c1c39a030aa79bd99ae731a58c01c1df',
     x86_64: 'd98e8bf6a856a84306eb4c29a6858307625cbc0f4eaa4a4344e5d9506406e5e3'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
