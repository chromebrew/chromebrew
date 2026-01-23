require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.46.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f48c21a26e6633a3dec18eb561b9ba2d5924f6064962baf20fa95b4100bb4d0a',
     armv7l: 'f48c21a26e6633a3dec18eb561b9ba2d5924f6064962baf20fa95b4100bb4d0a',
       i686: 'e99067f7b76a36f38ef1bc6f5edb388385a432ae3fb06fd854d5c6dccef7720a',
     x86_64: '54016d72d838d4c152ce33481aa8c91db5c3ec6c7b54dad139ff918bd3059468'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
