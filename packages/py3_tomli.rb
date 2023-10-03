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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.11_armv7l/py3_tomli-2.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.11_armv7l/py3_tomli-2.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.11_i686/py3_tomli-2.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_tomli/2.0.1-py3.11_x86_64/py3_tomli-2.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f2f9802f3affb0967f7d27085f9d0b53105ce2da5dbce892f9673c808d155ca5',
     armv7l: 'f2f9802f3affb0967f7d27085f9d0b53105ce2da5dbce892f9673c808d155ca5',
       i686: '5be0c7a5da8946cd13dad33e584de829397dcf5ab15cadbeee557b1a340ff5ad',
     x86_64: '5382309e7bc9730c4d6ebe399af7da09a3b2bc5d8c34395eed6d0bc3043b6d2b'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
end
