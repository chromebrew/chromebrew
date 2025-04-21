require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.26.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9095ee0e52472a7478c4131ad5aa45763e90260865ec26eb5f99586aa61b4dd',
     armv7l: 'b9095ee0e52472a7478c4131ad5aa45763e90260865ec26eb5f99586aa61b4dd',
       i686: '999ba7729eea9deed8e29898a51403c88fac939d5295756d092227ce16075e58',
     x86_64: 'c551a73d909b222f8eb4c17716804b3b112be99ff4464a90817d66c911aa2124'
  })

  depends_on 'python3' => :build

  no_source_build
end
