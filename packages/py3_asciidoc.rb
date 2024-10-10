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
  })

  depends_on 'python3'

  no_compile_needed
end
