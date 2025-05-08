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
       i686: '84cd405c13f2a8ee59506eb4774a5bad9249b7cf7700077d5988441166b2ac79',
     x86_64: '8626bc38307965996af5318aef1a17f9b9ce7c9017d0c0910e1467823709ac65'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  # no_source_build
  no_compile_needed
end
