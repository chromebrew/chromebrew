require 'buildsystems/pip'

class Py3_agate_dbf < Pip
  description 'Agate-dbf adds read support for DBF files to agate.'
  homepage 'https://agate-dbf.readthedocs.org/'
  version "0.2.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '800d4e481bd3d163ceec075d9cf3d02a7c0b9678fee140c83dca3cb756de1fa7',
     armv7l: '800d4e481bd3d163ceec075d9cf3d02a7c0b9678fee140c83dca3cb756de1fa7',
       i686: '8fbe26d205485e4225a0d8921aae5e506d055fe3c0173a94b42f514c1ee7fa59',
     x86_64: 'c8225eff24cddce0907ddd25d4f447bdbf786cca67b88e0a0929423dd97dd66b'
  })

  depends_on 'py3_dbfread'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  no_source_build
end
