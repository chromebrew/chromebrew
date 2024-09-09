require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version '2.4.8-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b68954e1b19ca28a521b60a0fbdc0d130c3396b5a4a761a7762cd212b3a78cf4',
     armv7l: 'b68954e1b19ca28a521b60a0fbdc0d130c3396b5a4a761a7762cd212b3a78cf4',
       i686: 'db70b26f714c6e330fcb99bf9f8286b040edf74ff920e6c98a8ae54a4d12993f',
     x86_64: '8d867afd8994e1e27ccda33a64ccb44a0bbd16ed22aa4f810e39f17c014b09b1'
  })

  depends_on 'python3' => :build

  no_source_build
end
