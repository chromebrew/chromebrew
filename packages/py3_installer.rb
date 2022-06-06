require 'package'

class Py3_installer < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  @_ver = '0.5.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/installer.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-1_armv7l/py3_installer-0.5.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-1_armv7l/py3_installer-0.5.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-1_i686/py3_installer-0.5.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_installer/0.5.1-1_x86_64/py3_installer-0.5.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b983cdc585808b6cb32c6d76cc7419694f5ec5108a5d01d6f0ad0b6691ca7bc9',
     armv7l: 'b983cdc585808b6cb32c6d76cc7419694f5ec5108a5d01d6f0ad0b6691ca7bc9',
       i686: '946e3b9788f5286c7b493ba1e53cc41fb79f12b68186a3cf656d70e911cc9679',
     x86_64: '64f779d7154541454cc84ba2aa8f0a098b26958aa4e4afce42d65bda511a56da'
  })

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
