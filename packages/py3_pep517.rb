require 'package'

class Py3_pep517 < Package
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  @_ver = '1.0.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pyproject-hooks.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_x86_64/py3_pep517-1.0.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'f1087c011dbb2d74864e1c96271a3ad0c3ce41e296eee722e7b359ac355b7680'
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
