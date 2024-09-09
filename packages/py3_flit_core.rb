require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version '3.9.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c35f598c0f9f060933d971bad1bdc5380447eaa5502e59338deefc0e20636dc2',
     armv7l: 'c35f598c0f9f060933d971bad1bdc5380447eaa5502e59338deefc0e20636dc2',
       i686: '90b3adcaf0b2a4ccba676ecff0cab233dc92c5ec5a7ab57e882b2f007fda9311',
     x86_64: '74f72a981bc87b998a08c6188647fb445b14fd17e18076e6fd1b0962c07cd34b'
  })

  depends_on 'python3'

  no_source_build
end
