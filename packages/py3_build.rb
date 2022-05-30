require 'package'

class Py3_build < Package
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  @_ver = '0.8.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/build.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.8.0_armv7l/py3_build-0.8.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.8.0_armv7l/py3_build-0.8.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.8.0_i686/py3_build-0.8.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_build/0.8.0_x86_64/py3_build-0.8.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '82001da40e13f38282b18237fb19ae2acaa5f618b1bea546705ec81fe66a10e1',
     armv7l: '82001da40e13f38282b18237fb19ae2acaa5f618b1bea546705ec81fe66a10e1',
       i686: 'b3979f3a2c4f020dc76a2b1517591af73476e4c03b3c3be4255d689e1c00fe46',
     x86_64: 'e1c0a3053b017e58ce6bfd2e1b24b5cff11488516d585389640d023e1f7e8c6f'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pep517'
  depends_on 'py3_tomli'

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
