require 'buildsystems/pip'

class Py3_fasteners < Pip
  description 'Fasteners provides useful locks for python programs.'
  homepage 'https://github.com/harlowja/fasteners/'
  version "0.20-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'baf5adadbf9121f4523e01f149b5a181c7826652097250e62e7d701b6a70144d',
     armv7l: 'baf5adadbf9121f4523e01f149b5a181c7826652097250e62e7d701b6a70144d',
       i686: '15754ad8c4f6eba7223ef1fda1a9f9c6d8bfd08ba22426ffbfafb2b46d3aab8a',
     x86_64: 'f43b2a439d6e533a76c827bae3a82178633d46ca774789486761199ed9bdc218'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
