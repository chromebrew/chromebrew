require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.13.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87891049d34e295be53ffc7f9fc4f0ebb8eb425be1a0a66d549a10e95e5ad70d',
     armv7l: '87891049d34e295be53ffc7f9fc4f0ebb8eb425be1a0a66d549a10e95e5ad70d',
       i686: '55f4c8894d27674b415f7916e3d96873c85df0b530d48199804308f262f18d61',
     x86_64: '66474bdaf6ec440e54565f39693d304fbe227a3204ce926a9eec15235ad31808'
  })

  depends_on 'python3' => :build

  no_source_build
end
