require 'buildsystems/pip'

class Py3_asciidoc < Pip
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'https://asciidoc.org/'
  version "10.2.1-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18dbbc553711b0fb28829d5e29910eb5965b92384a8c57e4ea5ae59a55bf5e1b',
     armv7l: '18dbbc553711b0fb28829d5e29910eb5965b92384a8c57e4ea5ae59a55bf5e1b',
       i686: '430871255d02c0343baf7d01c66d0f58d7dd433c39f76599abbaebe40f5980f7',
     x86_64: '03c4a8e2cdb86e7876f9bd88e1662bc1c7967342ffed965552912cb2ad7248c3'
  })

  depends_on 'python3' # R

  no_source_build
end
