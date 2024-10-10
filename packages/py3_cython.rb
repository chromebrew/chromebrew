require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.0.11-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae016973a5e65f87892471c0f56b817f0008a1d66bdd702fa4fefab9d4137128',
     armv7l: 'ae016973a5e65f87892471c0f56b817f0008a1d66bdd702fa4fefab9d4137128',
       i686: '91c9210bd9063d4a05dc12f11e2d5ca242cda76d26d450ee8917b5e6b9dea93c',
     x86_64: '29d97756783d6c634212dc6b9416ca25043f44dcceff6a4c0ba49eb882b88d36'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
