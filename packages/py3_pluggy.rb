require 'buildsystems/pip'

class Py3_pluggy < Pip
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  @_ver = '1.3.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.3.0-py3.12_armv7l/py3_pluggy-1.3.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.3.0-py3.12_armv7l/py3_pluggy-1.3.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.3.0-py3.12_i686/py3_pluggy-1.3.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.3.0-py3.12_x86_64/py3_pluggy-1.3.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0dd336a662156bd9e4a38020808f3ab263811a79cc6abde09487fc4a37ce1f7d',
     armv7l: '0dd336a662156bd9e4a38020808f3ab263811a79cc6abde09487fc4a37ce1f7d',
       i686: 'c2479cee3d970b77d63b5c4bdc5c7a898967f2bc6b723514894660d3bfa9e18d',
     x86_64: 'a6b0e3d74c870c859d75bdcd16a82ffe9b18dca1d931c44071f81a19cad80599'
  })

  depends_on 'python3' => :build
end
