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
    aarch64: '89c4b7252bee3fa56554ae99a4c5b60c5fc99959ea457e896c5d55b4d5618f12',
     armv7l: '89c4b7252bee3fa56554ae99a4c5b60c5fc99959ea457e896c5d55b4d5618f12',
       i686: 'd155250cf737282915e12c874cd3b646d3af4de37b128dea8f8870982049736d',
     x86_64: '79f3f5313e416e2c351799ecf84b58d4ac8924aad917af47137b3ba36b246e8d'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
