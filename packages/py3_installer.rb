require 'package'

class Py3_installer < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  @_ver = '0.7.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/installer.git'
  git_hashtag @_ver

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.7.0-py3.12_x86_64/py3_installer-0.7.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'fdf87ebe7f48cbff5347738a49c4f8b2615eba3b3708abfec9b2cfe8d9d12436'
  })

  depends_on 'python3'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
