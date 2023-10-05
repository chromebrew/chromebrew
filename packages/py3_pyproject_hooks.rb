require 'package'

class Py3_pyproject_hooks < Package
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  @_ver = '1.0.0'
  version "#{@_ver}-1-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pyproject-hooks.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyproject_hooks/1.0.0-1-py3.11_armv7l/py3_pyproject_hooks-1.0.0-1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyproject_hooks/1.0.0-1-py3.11_armv7l/py3_pyproject_hooks-1.0.0-1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyproject_hooks/1.0.0-1-py3.11_i686/py3_pyproject_hooks-1.0.0-1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyproject_hooks/1.0.0-1-py3.11_x86_64/py3_pyproject_hooks-1.0.0-1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5ba916f355743f059f8113e6d7eb984b6e554309400f8c2ec746c1a2d6f1b281',
     armv7l: '5ba916f355743f059f8113e6d7eb984b6e554309400f8c2ec746c1a2d6f1b281',
       i686: '504a11525def81a601f669747fe09ed34a73460eb75436ddf3e8cd7654832104',
     x86_64: 'ae826e30b3b8dbf8778ed068f30118444958c0b7af2f1dd45d23dac0bc1ee07f'
  })

  depends_on 'python3'
  depends_on 'py3_pep517' => :build
  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
