require 'buildsystems/pip'

class Py3_cmarkgfm < Pip
  description 'Python bindings to GitHub\'s cmark.'
  homepage 'https://github.com/theacodes/cmarkgfm'
  version "2024.1.14-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b5e988c19ae49eb31cd9606270b6d40bd523dc0722a970fa169730e5a92bcaa',
     armv7l: '3b5e988c19ae49eb31cd9606270b6d40bd523dc0722a970fa169730e5a92bcaa',
       i686: '5a768b234e73c912c8d7bc003564b7fd1895b1fdd0f6da211b09bd688de1a6f7',
     x86_64: '3736649f66cea64033366c138ca1c3de406744e6c65a2aab2a7e3bf80c27655b'
  })

  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' => :build

  no_source_build
end
