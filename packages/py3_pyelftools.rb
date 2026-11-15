require 'buildsystems/pip'

class Py3_pyelftools < Pip
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools/'
  version "0.33-#{CREW_PY_VER}"
  license 'public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dba675b0bc3e84811259f49dfd960dd8d9df94411b4c0cd6f7290d005cf5437d',
     armv7l: 'dba675b0bc3e84811259f49dfd960dd8d9df94411b4c0cd6f7290d005cf5437d',
       i686: 'fb2e4e57d8c4cdd9f73d48235a87bd8f8234579ce177428ea50b885480c15f14',
     x86_64: '02459e505b6dccddef9b47c95398da759ed560b5f4e9fd9e2535b8997940ba22'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
