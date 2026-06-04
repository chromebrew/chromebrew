require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.22-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20c9f8afc74fe387f41f0f719cd6e5157bc0812985f1a51ec86421a5f6e71e32',
     armv7l: '20c9f8afc74fe387f41f0f719cd6e5157bc0812985f1a51ec86421a5f6e71e32',
       i686: '3872c231f8cf4cd2f26840dbec8dd747a1760d07acd372f4cfd05fcab0eb3c38',
     x86_64: '8e80e0b0541dfa32961acce5324107cb4cd36b9831acba70064da4f2db281f9f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
