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
    aarch64: 'bfe9fda374c41ce9a192c09ded46cfe7d0adc4bfc16968aecaca2a207e0d03b4',
     armv7l: 'bfe9fda374c41ce9a192c09ded46cfe7d0adc4bfc16968aecaca2a207e0d03b4',
       i686: '5c1372f5216db83b45eaff6f145d4a41724a78156b72d015f6245b8b287b168e',
     x86_64: '0601c29846d4b34f9ffa4302538e7fe51d8b9b6e3efad342e14d3f09b0557869'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
