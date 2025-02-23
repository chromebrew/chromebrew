require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version "5.2.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b15288d0c84167e24f565def729b519d79433a3e53982df78fb52d1d9c7b683',
     armv7l: '7b15288d0c84167e24f565def729b519d79433a3e53982df78fb52d1d9c7b683',
       i686: '3c683ae6148a8031ce22b645605e4d6f7f23f16e27c652d358fd648ee84508d8',
     x86_64: '38f05b88546b1c02453449be7b89e22d415fa8c0dbc8f721973881d5ad4d83fb'
  })

  depends_on 'python3' => :build

  no_source_build
end
