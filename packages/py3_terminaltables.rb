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
    aarch64: 'c68f73510055c9c372446b88777f07b50b838514c71afe8f6fca90db86c7f8eb',
     armv7l: 'c68f73510055c9c372446b88777f07b50b838514c71afe8f6fca90db86c7f8eb',
       i686: '327886690102d62eb32c308c0d2b100941524c0a4428ea8f9a48b092a4d7b19b',
     x86_64: '84f2b86bfc4163d92b855d22e729226e9487f37d5db71d67444e0f5d51722c63'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'python3' => :logical

  no_source_build
end
