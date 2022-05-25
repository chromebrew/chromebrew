require 'buildsystems/python'

class Py3_wheel < Python
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  @_ver = '0.41.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.41.2-py3.12_armv7l/py3_wheel-0.41.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.41.2-py3.12_armv7l/py3_wheel-0.41.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.41.2-py3.12_i686/py3_wheel-0.41.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.41.2-py3.12_x86_64/py3_wheel-0.41.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2ab1df2dd39bedfa43d1b205951bf31fd765690d83c1d0f92b876a5f0f167b01',
     armv7l: '2ab1df2dd39bedfa43d1b205951bf31fd765690d83c1d0f92b876a5f0f167b01',
       i686: 'b0465f2da77d6fa29c49d64f86ff12e5fa3dd0697c4fe354fd23cc3cc1785398',
     x86_64: '7b32708d1bc0a6adbb1be5c584d80a21e0822dd81a07b0ab3a16b80e1747ebd2'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
end
