require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.37-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e0b9d6a5c27d975e2c5075ee92d6a05d08c1dae2436adfc8049a3a71c3bb598',
     armv7l: '4e0b9d6a5c27d975e2c5075ee92d6a05d08c1dae2436adfc8049a3a71c3bb598',
       i686: '913c317d573239ede44b9227f7b8e5fb20d171c3cebb95e0b1e557be2e957b36',
     x86_64: '2a1484778eb32654731c78e965df9ff3fb13c5fe13f807fee85c64976f890f64'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
