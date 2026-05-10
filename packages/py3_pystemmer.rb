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
    aarch64: '8d59d90604f452d5a6c46fc222370da78b120ece0089b1bfb7a859c7c89cec8f',
     armv7l: '8d59d90604f452d5a6c46fc222370da78b120ece0089b1bfb7a859c7c89cec8f',
       i686: '15241b661584f4f39f9394d5c556ce3980bd1a611bdc8bd97efa755663194740',
     x86_64: '63faa6a867abfdfe95298afe65bdc635d099133c6a4c2336c8a64712896e49de'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
