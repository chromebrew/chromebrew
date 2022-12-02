require 'package'

class Py3_setuptools_scm < Package
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm/'
  @_ver = '6.4.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools_scm.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/6.4.2-py3.11_armv7l/py3_setuptools_scm-6.4.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/6.4.2-py3.11_armv7l/py3_setuptools_scm-6.4.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/6.4.2-py3.11_i686/py3_setuptools_scm-6.4.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_scm/6.4.2-py3.11_x86_64/py3_setuptools_scm-6.4.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '18e57cf5827b6310023b910b4c6b089f7d96364397e5398f16068dbf896688bd',
     armv7l: '18e57cf5827b6310023b910b4c6b089f7d96364397e5398f16068dbf896688bd',
       i686: 'bb120e76501d1c509c9a025d7150e55d47c7b7627e72c5770555d5d3ff4930b6',
     x86_64: 'b458eaefab22a359a1604468b116cb50e6f95407bb2fcdf45d12ed224191c193'
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
