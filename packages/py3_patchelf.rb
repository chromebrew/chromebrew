require 'buildsystems/pip'

class Py3_patchelf < Pip
  description 'Patchelf is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://pypi.org/project/patchelf'
  version '0.17.2.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '886bf82495e4abc3b83c72a12e6ea1b313f26c2c66ffce7c0dd5a963e52b1869',
     armv7l: '886bf82495e4abc3b83c72a12e6ea1b313f26c2c66ffce7c0dd5a963e52b1869',
       i686: 'c4b9b418670f8d84f3ab7cd8c46b8393caf80494e1a8989cdf9b709f36e0a8d0',
     x86_64: '6f6a40b47f0298026b7bac3344bc3a70889d5488944c9299467b5a3c2f6ada4c'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # Conflicts with patchelf.
  no_source_build
end
