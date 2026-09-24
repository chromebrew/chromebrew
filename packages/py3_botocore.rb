require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.101-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b912e5863d4d888ea6a6c0e53992865dadb8f5c66262a6a368cb42fd379bc1c',
     armv7l: '1b912e5863d4d888ea6a6c0e53992865dadb8f5c66262a6a368cb42fd379bc1c',
       i686: '31b7986fab4e9672ea97b9be3ecbd628e41b66e470953bf868987f9d0123fb25',
     x86_64: 'c05c986aa15bf18b4dab781a38c45f983a5f69bcc327bdceab3f137852d9c189'
  })

  depends_on 'python3' => :logical

  no_source_build
end
