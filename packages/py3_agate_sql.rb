require 'buildsystems/pip'

class Py3_agate_sql < Pip
  description 'Agate-sql adds SQL read/write support to agate.'
  homepage 'https://agate-sql.readthedocs.org/'
  version "0.7.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7c8a337395025635ee1781f051a9e2b56e5c1bcfeddd944c21a43bf1769ae91',
     armv7l: 'f7c8a337395025635ee1781f051a9e2b56e5c1bcfeddd944c21a43bf1769ae91',
       i686: '9bd41a6572840f5d54df14be4c200afd889ba38ba5283c096261dc7b6f1b7380',
     x86_64: 'b513d75c88c879a312bee339981d0aab1558783c388b0f082ec9e8951481f665'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
