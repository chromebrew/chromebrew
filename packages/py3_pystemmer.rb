require 'buildsystems/pip'

class Py3_pystemmer < Pip
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  version "3.0.0-#{CREW_PY_VER}"
  license 'BSD MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8f563d3639047dca55684b2ad838b4e394a158aa97fd52335acb41f57100ab7',
     armv7l: 'a8f563d3639047dca55684b2ad838b4e394a158aa97fd52335acb41f57100ab7',
       i686: 'b208e6e20abd18baab0657120420c051dbcb1e80b372a72beb8e17d0c5ed7d03',
     x86_64: 'f77a7d9c2e2f0dfe28e4fd0bdfad90c170e4253700274f3b8f5aa03951c1a645'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
