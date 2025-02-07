require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.38-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cde0bb0c143895e6ff3210f40e36a524aa884a180efa483a6a5ee52aa6a40dae',
     armv7l: 'cde0bb0c143895e6ff3210f40e36a524aa884a180efa483a6a5ee52aa6a40dae',
       i686: '35024e94bdd92e3381d1ca830c2aeab507f4c000f185a173e5679d39d8c86be3',
     x86_64: 'f4e7dede9e51ab538cbf023fb0a739a28a6f9377cf8f764845050bc3c5b11e20'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
