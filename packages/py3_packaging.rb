require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "26.0-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e09331783d0a1688b18553193bbedf6bdd150e430a7814ab08f0c80f08a09ff',
     armv7l: '2e09331783d0a1688b18553193bbedf6bdd150e430a7814ab08f0c80f08a09ff',
       i686: 'ab75deab4b5ae79133609ff5745f8f9a5fd3cef4af4db7b7952794e456bfc85f',
     x86_64: '39769ba98404ccaad2a57c18136bf64eeae543cccee272f4f17eed57a266478e'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3'

  no_source_build
end
