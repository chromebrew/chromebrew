require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "4.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a32e340251e7d52b0c6ba645ce6180a92f91763490b2502a00bdc2cd49ee960d',
     armv7l: 'a32e340251e7d52b0c6ba645ce6180a92f91763490b2502a00bdc2cd49ee960d',
       i686: '85223ee685a1d315d4384f93fcd8a9ca732da1bbf0060cd6fca9244b44dcf2f6',
     x86_64: '90ca7e63f0b3addad4cdf4d5150775b4d18e90004c2d845ee8dbbef9b9d11bbf'
  })

  depends_on 'python3' => :logical

  no_source_build
end
