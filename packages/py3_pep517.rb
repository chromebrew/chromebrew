require 'package'

class Py3_pep517 < Package
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  @_ver = '0.12.0'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pep517.git'
  git_hashtag "v#{@_ver}"

  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
