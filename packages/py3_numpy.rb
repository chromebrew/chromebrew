require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.5.4-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cbd32948804aac903319498611fc34a3137bcdb70cbd2d4093dab87166d90e12',
     armv7l: 'cbd32948804aac903319498611fc34a3137bcdb70cbd2d4093dab87166d90e12',
       i686: '272607f7861a2670cb2ba9788b4ad03b865125970e1e8196a148cb67fd601005',
     x86_64: 'd33b48b3a6b117a6772c518723e6a7b921eb41825bad75b4d1df5bbad1ea6c18'
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
