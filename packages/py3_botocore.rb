require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.18-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b517671e90400303d1e1455ecc61d9580225a5ff1975fb2d3962174a1218656f',
     armv7l: 'b517671e90400303d1e1455ecc61d9580225a5ff1975fb2d3962174a1218656f',
       i686: 'e4e4ada1054cd4b8b5cb8e5c9ed0cbd5e8008dbc7f24df80d3b64660bb2277a0',
     x86_64: '219d7dff86d2bae6b3ec8f257a7c66753ce742a3b631f0bc0f867d51b10ba08a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
