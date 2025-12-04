require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  version "2.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de9a661a324899f9d0f8ff27abe975097a88e8f7f88b7087c30343b15d323117',
     armv7l: 'de9a661a324899f9d0f8ff27abe975097a88e8f7f88b7087c30343b15d323117',
       i686: '7252075ca97d17afead116d926b6434e88d0a4331953098af333db6d94e79b28',
     x86_64: '5a082e020f6cb7a0df2376f86dcbb3abe4e33114b88aa4d8e0f808ae064c6464'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R

  no_source_build
end
