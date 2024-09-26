# NOTE: Archived upstream

require 'buildsystems/pip'

class Py3_terminaltables < Pip
  description 'Terminaltables generates simple tables in terminals from a nested list of strings.'
  homepage 'https://robpol86.github.io/terminaltables/'
  version "3.1.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00bea5863b9fbe60cf85faacfe414a10f77f3be66aab93a19c124e822a5ce9c7',
     armv7l: '00bea5863b9fbe60cf85faacfe414a10f77f3be66aab93a19c124e822a5ce9c7',
       i686: '4019c3d5892b6beaf1510ceae4f402d6d3d765bf266f913d792a61035e59760a',
     x86_64: 'b32fddd74cdd6d0f57650e751a296cac6411c3ca979d9914d49b56594c2f247c'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'python3' => :build

  no_source_build
end
