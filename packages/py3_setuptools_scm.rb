require 'package'

class Py3_setuptools_scm < Package
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm/'
  @_ver = '6.4.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools_scm.git'
  git_hashtag "v#{@_ver}"
  git_clone_deep

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
