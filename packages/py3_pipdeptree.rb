require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.26.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '035b79ad1e22d1397294f9c148a853dddec5e5763c3abbb10f7a3e8603a446e4',
     armv7l: '035b79ad1e22d1397294f9c148a853dddec5e5763c3abbb10f7a3e8603a446e4',
       i686: '999ba7729eea9deed8e29898a51403c88fac939d5295756d092227ce16075e58',
     x86_64: 'c551a73d909b222f8eb4c17716804b3b112be99ff4464a90817d66c911aa2124'
  })

  depends_on 'python3' => :build

  no_source_build
end
