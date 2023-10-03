require 'buildsystems/python'

class Py3_tomli < Python
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/hukkin/tomli.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.12_armv7l/py3_tomli-2.0.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.12_armv7l/py3_tomli-2.0.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.12_i686/py3_tomli-2.0.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.12_x86_64/py3_tomli-2.0.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3c7be612da912852d98110637e4346235faec49c4a4040d0fec55ea7197bce98',
     armv7l: '3c7be612da912852d98110637e4346235faec49c4a4040d0fec55ea7197bce98',
       i686: 'c215a3c144b2f29f8a25e2aa32304db5bab81f9856aa03a1148a942828b3e1c6',
     x86_64: '4a0c7533e2b146e37ccf84c7e66b54f999dfe5ffc49af16529520aaa4fed693c'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
end
