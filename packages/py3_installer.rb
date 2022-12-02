require 'package'

class Py3_installer < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  @_ver = '0.5.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/installer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-py3.11_armv7l/py3_installer-0.5.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-py3.11_armv7l/py3_installer-0.5.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-py3.11_i686/py3_installer-0.5.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-py3.11_x86_64/py3_installer-0.5.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '86548f96668eab9e4630d354604c305ff38477cdcf4c3020812920fd2beeade8',
     armv7l: '86548f96668eab9e4630d354604c305ff38477cdcf4c3020812920fd2beeade8',
       i686: '49cbe5c506cccf3b1de5a75095d8f3f856e63f64bb6cdf7c130628d9fdf754c2',
     x86_64: '8b186cd29e05f9259395d356dff965dadc33dc344b4bdc159f0ef563bbd4d44f'
  })

  depends_on 'python3'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
