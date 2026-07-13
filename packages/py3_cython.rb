require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.2.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d1ef89bb3c9c6930f221d272f6e6cab70e94e07a227d17a33c7ebee311d06a9',
     armv7l: '9d1ef89bb3c9c6930f221d272f6e6cab70e94e07a227d17a33c7ebee311d06a9',
       i686: 'ab3a3824125946cc7fca6592ff754352a102faed1e03813a2f5e0491b76b1708',
     x86_64: 'dee5c7f9f062311f1e832b95785be7063c0d330fe55fcce7f8506f777434f718'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
