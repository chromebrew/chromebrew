require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.5.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b02729d4cd56274c071df8ebbd0525244e699cbba72ffe9f879cf4398591eb4c',
     armv7l: 'b02729d4cd56274c071df8ebbd0525244e699cbba72ffe9f879cf4398591eb4c',
       i686: 'b60283918a38ad66029a8854ffd4bd9a5ec4edcfeceead3c48a3154fc68f7493',
     x86_64: 'da187edbc18eb09502ee836c5f9d9b5fe28e50d6997ba14e90c6a9ee63784516'
  })

  depends_on 'python3' => :build

  no_source_build
end
