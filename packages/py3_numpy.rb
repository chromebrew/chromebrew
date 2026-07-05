require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.5.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '840059d9576a4acbd0420d6439294ac2ce9e69ce7fe2f478e7df55c4a8cae930',
     armv7l: '840059d9576a4acbd0420d6439294ac2ce9e69ce7fe2f478e7df55c4a8cae930',
       i686: '544be0c9f05def29fa3981bd011076b5c4e7bfd311c13938b2310e0182637a10',
     x86_64: '41462aa02b3b23bf631c7946d1f1dd16dea6a0b4436037a5e65e5424dfabe1e3'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lapack' => :library
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
