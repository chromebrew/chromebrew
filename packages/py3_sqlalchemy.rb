require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31a5101a825c5b2b20d0555a846e4a0ff0efd91bb5939ae279d67776ff69a658',
     armv7l: '31a5101a825c5b2b20d0555a846e4a0ff0efd91bb5939ae279d67776ff69a658',
       i686: '0d30b282636b4eb1d04402d2a15c32d64f6d27c2203f50ab7d6066cbb50fbf0a',
     x86_64: '50b87bab61296daa5b3408ab549f6310e137a8dc1364291c1c431c37910fc1c2'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
