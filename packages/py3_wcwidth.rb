require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e51d87376cc8b2aee469ba1ea9b3b91d9bf2e6affc073a34d5188bce827c1d00',
     armv7l: 'e51d87376cc8b2aee469ba1ea9b3b91d9bf2e6affc073a34d5188bce827c1d00',
       i686: '065df950cd74746f29ff8c0da96f17bf4386e51a91804796a19e4925fbf0a05d',
     x86_64: 'cea150101c6aaef730159ba236d38d2cb0291fd3757ec5806bad22e62f0dd749'
  })

  depends_on 'python3' => :build

  no_source_build
end
