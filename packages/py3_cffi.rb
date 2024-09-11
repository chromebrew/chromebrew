require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  version '1.17.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0f2226ef51361c6f24b6b40698cd30503f4f8ec74142754e4567e09a4d8242d',
     armv7l: 'd0f2226ef51361c6f24b6b40698cd30503f4f8ec74142754e4567e09a4d8242d',
       i686: 'ac881d61426ec5f3746d766fca86f6b16d16d57123a992507d911b1fdaab34ab',
     x86_64: 'bc02738b0516901a90ded65bebcf7b1ee6efb19118ae71e885d4b6af9acec335'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # L

  no_source_build
end
