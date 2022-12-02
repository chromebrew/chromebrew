require 'package'

class Py3_build < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  @_ver = '0.9.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/build.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-py3.11_armv7l/py3_build-0.9.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-py3.11_armv7l/py3_build-0.9.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-py3.11_i686/py3_build-0.9.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.9.0-py3.11_x86_64/py3_build-0.9.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b101ceec604ea1753eede1742182eb25e78a37def0134517e51921e2aebbab5d',
     armv7l: 'b101ceec604ea1753eede1742182eb25e78a37def0134517e51921e2aebbab5d',
       i686: '86e821ab691a2e89d724dfd81c7bee98caaedde748cc968ff3be01a672c52093',
     x86_64: 'd0a130d14079a39717926a7a4712a810c6a9574a2da38d47aad9cb1f94b59589'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
