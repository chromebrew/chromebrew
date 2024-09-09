require 'buildsystems/pip'

class Py3_pyelftools < Pip
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools/'
  version '0.31-py3.12'
  license 'public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e4edf6808fb4d4bbbfa28512188aebb92ae59a481d67da1608118f76434e6201',
     armv7l: 'e4edf6808fb4d4bbbfa28512188aebb92ae59a481d67da1608118f76434e6201',
       i686: 'f6c3291465311cbc68d2a6923ba775a17b06e5e1fa1d24e2d9bd13ff51119437',
     x86_64: '6daba124e65bcd8e121566a692385d50d1cd81e49a42ec62d6c08a0b8335ef56'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
