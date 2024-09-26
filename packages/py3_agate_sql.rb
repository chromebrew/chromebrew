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
    aarch64: 'c191f22dc224faa1a69669dffeaf9b106893245933840915fb1f1b9cfdbfd64f',
     armv7l: 'c191f22dc224faa1a69669dffeaf9b106893245933840915fb1f1b9cfdbfd64f',
       i686: '824385f1089c2be975bb71dd7333435377a512a98dd17b91202fb5f389521b53',
     x86_64: 'b513d75c88c879a312bee339981d0aab1558783c388b0f082ec9e8951481f665'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
