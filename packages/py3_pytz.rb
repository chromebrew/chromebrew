require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2026.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f25409b32ce00fcfbd5198d72b172329136b38aa71bd22536138fdcc6c6fedb4',
     armv7l: 'f25409b32ce00fcfbd5198d72b172329136b38aa71bd22536138fdcc6c6fedb4',
       i686: '385b4794df1be4546194b753c0ed233602eca21430fb5f942b95f8796d2e8700',
     x86_64: 'dd88b33b33c1719580685d6f9e4a55a8a66eed22b8d06db2e35bda1e549e8bbf'
  })

  depends_on 'python3' => :logical

  no_source_build
end
