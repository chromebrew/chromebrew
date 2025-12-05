require 'buildsystems/pip'

class Py3_isodate < Pip
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  version "0.7.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b9b4cd4c22e0b8a655f7a11c3c2b55c623deccf5f028ac1c5be24e0e11f116b',
     armv7l: '9b9b4cd4c22e0b8a655f7a11c3c2b55c623deccf5f028ac1c5be24e0e11f116b',
       i686: '36a483d690a98de5568d8441ae7c6fa7334260728a8f269cff42f08efcfa8899',
     x86_64: '9221e207e82bf46c0248bb17e5ca7c6d81e2d1d60c142d58686846b4897a425d'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
