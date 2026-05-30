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
    aarch64: '333211d83f73d1d010e18294109bbb4a0007b1d176c56d3b08b4f6ba286ad147',
     armv7l: '333211d83f73d1d010e18294109bbb4a0007b1d176c56d3b08b4f6ba286ad147',
       i686: '184c87429286fe58eaff436fd05537cd2e1f61c47df12b3edfdea7562ce5e451',
     x86_64: '9b372a8182c9350fd4642acfa108f87d9063f3a873731d16dd5ee41d0065d660'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
