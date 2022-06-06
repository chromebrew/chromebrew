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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/6.4.2_armv7l/py3_setuptools_scm-6.4.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/6.4.2_armv7l/py3_setuptools_scm-6.4.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/6.4.2_i686/py3_setuptools_scm-6.4.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/6.4.2_x86_64/py3_setuptools_scm-6.4.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9b5b91ad8203d75215a339bce5cedc337ffce576851d37294e2af274eef059fb',
     armv7l: '9b5b91ad8203d75215a339bce5cedc337ffce576851d37294e2af274eef059fb',
       i686: '50bfe3303806501dc0467e9e2db1518647762ac4e81f069d63ced8c3f9a9f7e9',
     x86_64: '332382dcabe40c4fa4df4b1f4966a99f3a1e359dafa9481530881b2b4ef75169'
  })

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
