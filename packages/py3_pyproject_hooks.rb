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
    aarch64: 'bf73236a9802a89c2dcdeadd958f888a8a7464cf279e72e59a075171c9728050',
     armv7l: 'bf73236a9802a89c2dcdeadd958f888a8a7464cf279e72e59a075171c9728050',
       i686: '7d5bb4006e0503a520b0262364c70177838b467b21492c10d0f52dbfdb7dcfc0',
     x86_64: '4056bb0bddf75f921e5dd4b10139bfa0458cf744ccaba5583eb3d623269970b5'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
