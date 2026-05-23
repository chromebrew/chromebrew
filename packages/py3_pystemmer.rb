require 'buildsystems/pip'

class Py3_pystemmer < Pip
  description 'Snowball stemming algorithms, for information retrieval'
  homepage 'http://snowball.tartarus.org'
  version "3.1.0-#{CREW_PY_VER}"
  license 'BSD MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3468f71f801bf8d16f2bb2fb775e7771ec50500d19a4b430f09d3e1043b0a061',
     armv7l: '3468f71f801bf8d16f2bb2fb775e7771ec50500d19a4b430f09d3e1043b0a061',
       i686: '71f2160b6d77cc93bd278430ac1609158004837de2dd1362756ab29cae0b1db5',
     x86_64: 'f29210d02847c6b7503198484f67bbc8d531f5307d19d5fe9043f695d296b9d4'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
