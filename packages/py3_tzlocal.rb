require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version "5.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99785137fb543c14fbb48c6bbefdc6dc18ee5d31ca1e8e34f2df88a9111ac0cd',
     armv7l: '99785137fb543c14fbb48c6bbefdc6dc18ee5d31ca1e8e34f2df88a9111ac0cd',
       i686: 'd4d0c4f0514d6b6acc43282bc3a65600eb5f2105988acdd4763852ba64e1715a',
     x86_64: '811a19acde95036810833b24f8cc8055129d980413cef0b8dbb1a8866ad99137'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :logical

  no_source_build
end
