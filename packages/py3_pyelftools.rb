require 'buildsystems/pip'

class Py3_pyelftools < Pip
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools/'
  version "0.32-#{CREW_PY_VER}"
  license 'public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcff72eed5fef7780bc7b15579701e2b951187fa9fa486140d0bd829bccc1211',
     armv7l: 'bcff72eed5fef7780bc7b15579701e2b951187fa9fa486140d0bd829bccc1211',
       i686: 'c628bc1729ffd315bb10e4b718df884bb07b24e4ef21a30119487edcc99cc27f',
     x86_64: 'fcde897298816a3bf212f1ddb5db3fe7c9377b2717b021bb82e3be448d70e8b3'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
