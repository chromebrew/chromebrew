require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '965a2536f5d508eb3e136ca3ab7b46904dae39d615080f6ffd9387ae58d5b96f',
     armv7l: '965a2536f5d508eb3e136ca3ab7b46904dae39d615080f6ffd9387ae58d5b96f',
       i686: 'dc18c26a16db88267734a96477ddbbe83ec634da687d797eec90a95793f44dea',
     x86_64: '0807dabde7b39e02eb2241f440071620afb3b9d69be11f29f090cdb8d534ef44'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
