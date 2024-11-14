require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.45.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf532251ce69c32749d34c6a58fc5ec896f7004ead71c1d1e95fdcf0bd56276d',
     armv7l: 'cf532251ce69c32749d34c6a58fc5ec896f7004ead71c1d1e95fdcf0bd56276d',
       i686: 'b2dd37e2b8d40769a9f8983139986c708d3d126d8fa1dbdb5102775bb285c4c8',
     x86_64: '5c7b4b02852cf2d2c08d9f3b83641fc36b298f5e88b2c8344eedaebe2a35952a'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
