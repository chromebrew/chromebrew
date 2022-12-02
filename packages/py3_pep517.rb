require 'package'

class Py3_pep517 < Package
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  @_ver = '0.12.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pep517.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-py3.11_armv7l/py3_pep517-0.12.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-py3.11_armv7l/py3_pep517-0.12.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-py3.11_i686/py3_pep517-0.12.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0-py3.11_x86_64/py3_pep517-0.12.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e77638b9339f8b30bd99b1a780992c4c6e6b6c64a0a2d14b474ee5e5c53c2af8',
     armv7l: 'e77638b9339f8b30bd99b1a780992c4c6e6b6c64a0a2d14b474ee5e5c53c2af8',
       i686: '4b1553ad456e3d9721750275df595f1fbd8102dfb9e9d0555aee2a2c240adb75',
     x86_64: '84beaaca58b1b64ac5820a1e71f496aae8e4bba5f68c048be71295e0083f8a9c'
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
