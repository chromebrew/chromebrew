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

  binary_sha256({
    aarch64: '2ab1df2dd39bedfa43d1b205951bf31fd765690d83c1d0f92b876a5f0f167b01',
     armv7l: '2ab1df2dd39bedfa43d1b205951bf31fd765690d83c1d0f92b876a5f0f167b01',
       i686: 'b0465f2da77d6fa29c49d64f86ff12e5fa3dd0697c4fe354fd23cc3cc1785398',
     x86_64: '7b32708d1bc0a6adbb1be5c584d80a21e0822dd81a07b0ab3a16b80e1747ebd2'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
end
