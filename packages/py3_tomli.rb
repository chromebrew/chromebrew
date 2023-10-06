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
    aarch64: '35692904b29b433587a5e52cb4f128624d9df8ede7020777860b9296917d62ff',
     armv7l: '35692904b29b433587a5e52cb4f128624d9df8ede7020777860b9296917d62ff',
       i686: 'c8e83f1e16cd0e1c2b0e322361963b40e6ba32bfaf59aa342557768bee5fe4a1',
     x86_64: '09bcd13b118d79e12eb097525d90555fb7180883db0c6cb91bf0264f8bc0b09b'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
end
