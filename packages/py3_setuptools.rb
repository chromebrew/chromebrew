require 'buildsystems/python'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '68.2.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/65.6.3-py3.11_armv7l/py3_setuptools-65.6.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/65.6.3-py3.11_armv7l/py3_setuptools-65.6.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/65.6.3-py3.11_i686/py3_setuptools-65.6.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/65.6.3-py3.11_x86_64/py3_setuptools-65.6.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd357201c692981911586872b1d7f0b6900b886d13202a50aaedf91f02942db08',
     armv7l: 'd357201c692981911586872b1d7f0b6900b886d13202a50aaedf91f02942db08',
       i686: '876fc977e01a7d639adef3a9a7403813cf599f98d0c28d9d7d906d6fba73b34c',
     x86_64: '483166d8742478f87585c5a10d10fafd5953dabb1c6e435d2c13d5bccebcd74a'
  })

  depends_on 'python3', '< 3.13.0'
  depends_on 'py3_packaging'

  conflicts_ok

end
