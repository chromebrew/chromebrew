require 'package'

class Py3_pyproject_hooks < Package
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  @_ver = '1.0.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pyproject-hooks.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyproject_hooks/1.0.0-py3.11_armv7l/py3_pyproject_hooks-1.0.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyproject_hooks/1.0.0-py3.11_armv7l/py3_pyproject_hooks-1.0.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyproject_hooks/1.0.0-py3.11_i686/py3_pyproject_hooks-1.0.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyproject_hooks/1.0.0-py3.11_x86_64/py3_pyproject_hooks-1.0.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '21f517d2022987ada64860830426cb7f7a769e405d42cb381f24063629433e55',
     armv7l: '21f517d2022987ada64860830426cb7f7a769e405d42cb381f24063629433e55',
       i686: '3de0b5be888db9484499d5083ed1011908945e36603fff4a2386869a5ba897ce',
     x86_64: 'bc0168df62eb6b2c238a49bbfa289cdb1e3941648e8d6427552a9270fefc6579'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
