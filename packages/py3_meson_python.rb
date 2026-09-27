require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.22.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd7f2ae3abc34aacf6f574b50f1830d47f6c60b90bf3ef806a8ede058bf7af66',
     armv7l: 'fd7f2ae3abc34aacf6f574b50f1830d47f6c60b90bf3ef806a8ede058bf7af66',
       i686: '3e162e63037178ca28d41031cd86884d3e624bc362f43cca17135f2d8af8a642',
     x86_64: '39298e0a01946c6eea6c7a6e60950fa46041c5be3efbaac2fff82de1ea46091a'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
