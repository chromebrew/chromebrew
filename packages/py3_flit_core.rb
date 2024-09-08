require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68402651f832c896ff80e5b44435a60dc9123f89bf36a1656bc572f42731c817',
     armv7l: '68402651f832c896ff80e5b44435a60dc9123f89bf36a1656bc572f42731c817',
       i686: '01a2f8a973d3d1a298221235bd99043d05980de1d79bacf8a03173fe0ef653b3',
     x86_64: 'd870b86028d67c97728d91a490a93e473db11121f6f39c42890a3db8d0cc7407'
  })

  depends_on 'python3'
end
