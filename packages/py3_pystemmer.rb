require 'buildsystems/pip'

class Py3_pystemmer < Pip
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  version "2.2.0.1-#{CREW_PY_VER}"
  license 'BSD MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72e21d7400cd773a2b60bed2f70ef09377361e546e7f1cc6374b53e1628f7507',
     armv7l: '72e21d7400cd773a2b60bed2f70ef09377361e546e7f1cc6374b53e1628f7507',
       i686: '001161fce6f25ba29566b534b903904f93ae8f16609e7c6788f545ca5040ef1d',
     x86_64: '7a16ed357d7f351488615526e93ba44e61ce1daeba87a6fb39149908f55b4abe'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
