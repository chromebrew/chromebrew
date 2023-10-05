require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '23.2'
  version "#{@_ver}-py3.12"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/23.2-py3.12_armv7l/py3_packaging-23.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/23.2-py3.12_armv7l/py3_packaging-23.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/23.2-py3.12_i686/py3_packaging-23.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/23.2-py3.12_x86_64/py3_packaging-23.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dc92faa2d9f20a67fc817d15834d298a51b324863f2e588a6269b3596f16325e',
     armv7l: 'dc92faa2d9f20a67fc817d15834d298a51b324863f2e588a6269b3596f16325e',
       i686: '4ecc2de5542e6799e3a684eb82ba0717e588ed1e3537c234025418edfe904e0f',
     x86_64: 'e5792452bfc3e37c0064921035b73dc1b4c54b1d75a294bbe38673533da6365b'
  })

  depends_on 'python3'
  depends_on 'py3_pyparsing'
end
