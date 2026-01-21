require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.31-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb7eb5a03ac1737c68c331560fe1c0f8d14867a38c8ebac5a6bc4dbba2df1d65',
     armv7l: 'eb7eb5a03ac1737c68c331560fe1c0f8d14867a38c8ebac5a6bc4dbba2df1d65',
       i686: '057d8116edb1e12ec054b338be217b5297245b65d029fc86964d24259f659366',
     x86_64: '23345ab179a519f96c0e0ead4b7b40e5a78bc6f524326c3f03c25a10858fc004'
  })

  depends_on 'python3' => :build

  no_source_build
end
