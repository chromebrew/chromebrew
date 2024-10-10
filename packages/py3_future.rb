require 'buildsystems/pip'

class Py3_future < Pip
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  version "1.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b91f30c1d61ee00f2196c958ba30da49a8e9f1ea5f74195f6b31ca7b31f982e3',
     armv7l: 'b91f30c1d61ee00f2196c958ba30da49a8e9f1ea5f74195f6b31ca7b31f982e3',
       i686: '2a9949d18cf254a1820ddbf5ea726a96166796f703328eb8460e059d25b7e352',
     x86_64: '01d989a8ac7df50d96f5d345e2da40904cdd58eb69f626bec2344692e7e60298'
  })

  depends_on 'python3' => :build

  no_source_build
end
