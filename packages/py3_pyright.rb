require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version '1.1.381-py3.12'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.28'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e2a27cc388b16710dfb2f9733079bd96688c279285031596fa5d6b389417f47',
     armv7l: '3e2a27cc388b16710dfb2f9733079bd96688c279285031596fa5d6b389417f47',
     x86_64: 'f7ab8602fdeea9451bcc63403dac6a20a3a0264fe626690f700d46f0ae8c649f'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
