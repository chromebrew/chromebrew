require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version '0.2.13-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eafccbeb677bd48e7a034c57562bb918f6d3374564062ad6625ac3e5bd55c57a',
     armv7l: 'eafccbeb677bd48e7a034c57562bb918f6d3374564062ad6625ac3e5bd55c57a',
       i686: '1e9353966ab6af3ed82050c8062ee955e29ae82230e1f9319ff39c831f898a4f',
     x86_64: '209528d1bd8e7fbe2b07d1187c174258b55dd3cbdd8a7c5b7779203d6e670832'
  })

  depends_on 'python3' => :build

  no_source_build
end
