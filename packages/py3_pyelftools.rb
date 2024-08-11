require 'buildsystems/pip'

class Py3_pyelftools < Pip
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools/'
  version '0.29-py3.12'
  license 'public-domain'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_compile_needed
end
