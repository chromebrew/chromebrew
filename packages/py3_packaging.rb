require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.3'
  version "#{@_ver}-py3.12"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.12_armv7l/py3_packaging-21.3-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.12_armv7l/py3_packaging-21.3-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.12_i686/py3_packaging-21.3-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3-py3.12_x86_64/py3_packaging-21.3-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9d73d22fa4113a81c3a57a21159659fdc41b627d53f889d5430e5447190f9eef',
     armv7l: '9d73d22fa4113a81c3a57a21159659fdc41b627d53f889d5430e5447190f9eef',
       i686: '97c2f7b4316602774020380014106218be566453034414e5abe0887cca2165b4',
     x86_64: '1f9e5aeafc90301b5c82051680f43453d718ce3d31ef6b125de46a80584e6707'
  })

  depends_on 'python3'
  depends_on 'py3_pyparsing'
end
