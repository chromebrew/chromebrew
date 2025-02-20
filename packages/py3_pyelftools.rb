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
    aarch64: 'd30cee2389ab5fbb6a048fea7fd5ea316daa38f4170f8700acaa8fe477555067',
     armv7l: 'd30cee2389ab5fbb6a048fea7fd5ea316daa38f4170f8700acaa8fe477555067',
       i686: 'decadefabc6eba7a020612af5545f43403cecefc560966fd7738ec22f8bdd98d',
     x86_64: '1e3308c2fd122ea76d03213c26962eb4c39c717a86507cf020614a5a9739edd7'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
