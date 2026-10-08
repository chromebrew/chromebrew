require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '494c44e0fc86fc6a5aea1ed7a4ca7e70cb9809fd5af5c9b3c0153cb6075865f0',
     armv7l: '494c44e0fc86fc6a5aea1ed7a4ca7e70cb9809fd5af5c9b3c0153cb6075865f0',
       i686: '96e39d58817393b72678f69a678fc53c8d118aaccbf2d22fd7addc108bc75b29',
     x86_64: '7839ade415573bb5f1ad4fd952a60fe955342a0636d7d564c0479979130dd66e'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
