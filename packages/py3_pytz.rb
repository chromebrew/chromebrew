require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2026.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc31bed1002aa872c78dc69f4cc56919976d6906ce6fdb025d58e9e7bbcb4bdc',
     armv7l: 'fc31bed1002aa872c78dc69f4cc56919976d6906ce6fdb025d58e9e7bbcb4bdc',
       i686: '4ecc886a2020e5c6c0b75dc89919d3d0559ddb0ad869b94cec43b137104fd6b7',
     x86_64: '2b7ee3585fc31f85fbb1705cced4271804f98cd271628de94f54e05aae701a25'
  })

  depends_on 'python3' => :logical

  no_source_build
end
