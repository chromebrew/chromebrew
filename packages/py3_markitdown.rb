require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '471672cfc197ace5130edf70633b3e4fded9f0eed8900e1a9b170e146891cecf',
     armv7l: '471672cfc197ace5130edf70633b3e4fded9f0eed8900e1a9b170e146891cecf',
       i686: 'e13d6f22cce5448f37a2699bae92264e1e57723ebebb2444eea2a805fcc987ef',
     x86_64: 'c2965e8227bd85bc98ffebf6ab18ca7875b5a8bc4fab532193d94793b1f3817e'
  })

  depends_on 'python3' => :build

  no_source_build
end
