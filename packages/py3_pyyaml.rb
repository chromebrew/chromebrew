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
    aarch64: 'bc8bdf7e1975ac702f5db16b7842eb981ac14fec43a5c1d38524171061081550',
     armv7l: 'bc8bdf7e1975ac702f5db16b7842eb981ac14fec43a5c1d38524171061081550',
       i686: 'fcfcf65c6d2e02196a3918e0a1700fe0649f3cb4a81227c66389d9704355117c',
     x86_64: 'de32c1ba7ee0d6800f042060aa655aaa5a7d67f467ada70b756a82f31e766277'
  })

  depends_on 'glibc' # R
  depends_on 'libyaml' # R
  depends_on 'python3' => :build

  no_source_build
end
