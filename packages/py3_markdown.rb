require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.8-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c08e7017fcd8bd11525a5793d473e615ac576ca52410ce60bcb4684a0e28f41',
     armv7l: '1c08e7017fcd8bd11525a5793d473e615ac576ca52410ce60bcb4684a0e28f41',
       i686: '5502206b4a94ae0ccdfc4de92446db66cb1acaf537cf69e4e9f5dece0441bf40',
     x86_64: 'dbda31344df6827ed75bb78e6af1e0e14d5c501f1b83d76d7c81448a4a9aa809'
  })

  depends_on 'python3'

  no_source_build
end
