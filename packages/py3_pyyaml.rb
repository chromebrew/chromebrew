require 'buildsystems/pip'

class Py3_pyyaml < Pip
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  version "6.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e567d3dcdb6ab86c3848775f7bcf512e0a6e89d83ca84866f576f868c16c7c8',
     armv7l: '4e567d3dcdb6ab86c3848775f7bcf512e0a6e89d83ca84866f576f868c16c7c8',
       i686: '2751f0a93dc808dd3ab1c478f007a0e084c12d48197f9e8a81fce756223a0388',
     x86_64: '34ef78071e59ad0dcd0b4e69d089cc1fd90fa94621370fc08b2d78a83d615bc1'
  })

  depends_on 'glibc' # R
  depends_on 'libyaml' # R
  depends_on 'python3' => :build

  no_source_build
end
