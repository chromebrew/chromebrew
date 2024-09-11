require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version '24.1-py3.12'
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52c6b523c92f14ab1b532f02d60b338b386872b8f8fce960b7d6624cabfe5ec2',
     armv7l: '52c6b523c92f14ab1b532f02d60b338b386872b8f8fce960b7d6624cabfe5ec2',
       i686: 'c4a36dd5a3b89e29ff7d7e090440b28b70029842b49d97f948435f9e6155d73c',
     x86_64: '0b41b2620b659bdd9350819deaaf38574d0651bcdb46776140249fd11493096c'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3'

  no_source_build
end
