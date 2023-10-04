require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '23.2.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/23.2.1-py3.12_armv7l/py3_pip-23.2.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/23.2.1-py3.12_armv7l/py3_pip-23.2.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/23.2.1-py3.12_i686/py3_pip-23.2.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/23.2.1-py3.12_x86_64/py3_pip-23.2.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '158b83094f5520b638bee16c5599bd0135382b58b43fa4b3a83c53ed9121856e',
     armv7l: '158b83094f5520b638bee16c5599bd0135382b58b43fa4b3a83c53ed9121856e',
       i686: 'a0a695312be7d34ced2c4087a39257cff87b37f9994c46e44f395d4bc2a0957b',
     x86_64: 'd159d50bae5227068e20403c6b08069303a5afcb725a99ec325238719de2e9dc'
  })

  depends_on 'python3', '< 3.13.0'

  conflicts_ok
end
