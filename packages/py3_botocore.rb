require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.76-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca2e0669dfce7bf47292553c29afe353ec843b187c03897071a87653d3af5f41',
     armv7l: 'ca2e0669dfce7bf47292553c29afe353ec843b187c03897071a87653d3af5f41',
       i686: '19eea54394878e02a9558c33bb8b98d766ed733cad57f4c30391a193387cce0f',
     x86_64: '2e522e56fafb2b1459d11311867c21fe43ac2e28672caf0fd7e727dc8d8d186b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
