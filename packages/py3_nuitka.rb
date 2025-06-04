require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3d4af2f4a94c87b2dba944c34a27c67bc11b4bad226017982cd3b9fdaa8c6aa',
     armv7l: 'd3d4af2f4a94c87b2dba944c34a27c67bc11b4bad226017982cd3b9fdaa8c6aa',
       i686: '65eae24624a271dda0305e7fa24e0ff9184ad5594913f16a1c7fae8b4988cf68',
     x86_64: 'e996f12f435801211dd6425e5f2a26f2a9fe2fa6abd6b3d557dcb965aadae722'
  })

  depends_on 'python3' => :build

  no_source_build
end
