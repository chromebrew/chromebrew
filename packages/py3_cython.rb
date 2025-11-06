require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9dda2ab2c79df9b3148f475ca1ce9096082e7fd9713f5ba13f2ee53ca41769dd',
     armv7l: '9dda2ab2c79df9b3148f475ca1ce9096082e7fd9713f5ba13f2ee53ca41769dd',
       i686: '3845ab51e4f65774efc01752006c4f4813e93108332c482be96de82e58969d0e',
     x86_64: 'e5c3ec7de70393275935d07f6384400909d0781b396d75b128874e8e286166ec'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
