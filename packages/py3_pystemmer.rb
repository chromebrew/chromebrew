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
    aarch64: '72e21d7400cd773a2b60bed2f70ef09377361e546e7f1cc6374b53e1628f7507',
     armv7l: '72e21d7400cd773a2b60bed2f70ef09377361e546e7f1cc6374b53e1628f7507',
       i686: 'b208e6e20abd18baab0657120420c051dbcb1e80b372a72beb8e17d0c5ed7d03',
     x86_64: '8626bc38307965996af5318aef1a17f9b9ce7c9017d0c0910e1467823709ac65'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
