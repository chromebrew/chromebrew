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
       i686: '913c317d573239ede44b9227f7b8e5fb20d171c3cebb95e0b1e557be2e957b36',
     x86_64: 'b48eb2ce41bea88a6417b854c20d0d66837a2b2c7ed5c3064dc90f16db50d21c'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
