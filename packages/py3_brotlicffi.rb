require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  version "1.1.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd528efdfe14773b27ea0345b76d02cb876f0e3b40e158bfe4ae49ad65ec9162',
     armv7l: 'cd528efdfe14773b27ea0345b76d02cb876f0e3b40e158bfe4ae49ad65ec9162',
       i686: 'f77fe20b7cfec292b6c9d0af017d8d8876f6af8f543e7123c36e770430217cab',
     x86_64: '2c25cdf07f279de5a1884d4598b0f9230c2489f4e68030f324fef560784d8b97'
  })

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' # L

  no_source_build
end
