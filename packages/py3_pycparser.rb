require 'buildsystems/pip'

class Py3_pycparser < Pip
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  version "3.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd026db81de35dd4a831610fcdc993e3c04ca752a5e00a4b9395f92d02af669d5',
     armv7l: 'd026db81de35dd4a831610fcdc993e3c04ca752a5e00a4b9395f92d02af669d5',
       i686: 'a4f58bb9ceb6c6389d39f9753f1d12897268ec57ff20f47aa1cdf73367ce8b3c',
     x86_64: '56209f81d2a8d40de4f45d82fa2266b3e3d22168b840a76d40b502393a0ef4d9'
  })

  depends_on 'python3' => :build

  no_source_build
end
