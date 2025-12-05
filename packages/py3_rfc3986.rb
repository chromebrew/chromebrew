require 'buildsystems/pip'

class Py3_rfc3986 < Pip
  description 'A Python implementation of RFC 3986 including validation and authority parsing.'
  homepage 'http://rfc3986.readthedocs.io'
  version "2.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ddea3213035251976a9a6aa406673fef6df08d50bf2b3c514dc83809eb2fdf8',
     armv7l: '8ddea3213035251976a9a6aa406673fef6df08d50bf2b3c514dc83809eb2fdf8',
       i686: '59b7d92fcacc88123337216df407bc2300e01640941eccf11da0e9b57725eca5',
     x86_64: 'a62aea344cd039edfe4ddd093d63f91f71bd262cd4a58f6f028e88b9a648e039'
  })

  depends_on 'python3' => :build

  no_source_build
end
