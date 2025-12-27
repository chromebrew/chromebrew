require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.11-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd42e1225fb5827b1aa8d3d62aa86bb95a3818ea27e3277fe676217796e5720d3',
     armv7l: 'd42e1225fb5827b1aa8d3d62aa86bb95a3818ea27e3277fe676217796e5720d3',
       i686: '9749151654e934d1df4a2c30700da3f61bcd2433dff870449b7fea508a61e361',
     x86_64: '233be427e54901b0334e85d16ec6dbc1aabaaa4cab89ee6efe243ac22be13eb2'
  })

  depends_on 'python3' => :build

  no_source_build
end
