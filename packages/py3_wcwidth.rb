require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.8.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '694f0cc1b4b35f05a937fbdc64afe4394d72e98b5bfe9b205832ceeaf968dbb2',
     armv7l: '694f0cc1b4b35f05a937fbdc64afe4394d72e98b5bfe9b205832ceeaf968dbb2',
       i686: '5db064a71177e664d407c4cddbfbca1ed792b0d559c7c668f190e1673f47deb5',
     x86_64: 'c7893c47ace243a38c604e73d5ea4e2c8c9dfeb5c13da12624f85023c127aa30'
  })

  depends_on 'python3' => :logical

  no_source_build
end
