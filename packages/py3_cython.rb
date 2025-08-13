require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.1.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f3674d0ccbc5b55e35a8650ea0e7aff5a56b98b8d290998dbf2bb4cd4261993',
     armv7l: '9f3674d0ccbc5b55e35a8650ea0e7aff5a56b98b8d290998dbf2bb4cd4261993',
       i686: '2bd6e9c3a124a4b7aadcc72de5e9305429edfca725b92b9dd354e3e2fefa322d',
     x86_64: '62559a10f612a428cb91104d46515a66e4cf657ba98d850d09735005303f91fd'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
