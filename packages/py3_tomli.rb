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
    aarch64: '61dbfafd949c4991a945a9fcce2b949f0ed325fedb2a350248b10283dba204d0',
     armv7l: '61dbfafd949c4991a945a9fcce2b949f0ed325fedb2a350248b10283dba204d0',
       i686: '360bbb2634e35761dfde2b39ef206d494b026528dd426957ecba714537ba4a26',
     x86_64: 'd7da94aa98fcd43e3c4ffabe53cad959bac1c75f4b7a7f73880a53ec65e4d3cc'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
end
