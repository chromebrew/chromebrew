require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "26.3-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4955ccae9541ebef62fc04bc3898402053d26154fbbbf8a23df8656b70a8f802',
     armv7l: '4955ccae9541ebef62fc04bc3898402053d26154fbbbf8a23df8656b70a8f802',
       i686: '59ac357d35ca965770b8514e9da73abf3c1599e388db9f350f2149a9c93c5472',
     x86_64: '2939320f072fdc90e1c66ccbafa1160137b84b70249fde5206d931c8f776f6b7'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3' => :logical

  no_source_build
end
