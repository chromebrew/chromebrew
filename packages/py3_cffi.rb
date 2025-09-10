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
    aarch64: '1ca6f3f4f3ac6b4cadd5de8d5c9cdcc38f42fd2a9c760a7b09b9759f951ae90d',
     armv7l: '1ca6f3f4f3ac6b4cadd5de8d5c9cdcc38f42fd2a9c760a7b09b9759f951ae90d',
       i686: 'b8cb7ca6069c829d083d1f06a195893411cd3b99d53a7d7fe6cda40089dd5a78',
     x86_64: 'c92709e75b88270aba80f7197a4a57b0e20ffbb8fb8370fcd53d4242fd51821f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R

  no_source_build
end
