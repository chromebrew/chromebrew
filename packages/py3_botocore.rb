require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b00ab2787d172437caff0ef59bb6b5ca1b72b280721e25544a53c9f46bc850d4',
     armv7l: 'b00ab2787d172437caff0ef59bb6b5ca1b72b280721e25544a53c9f46bc850d4',
       i686: '7df9d97672e1f667b8d8ecd7ff47113206ded851a2592213566729064a8756a5',
     x86_64: '54dff4caefb851e4a897cb9279207dfc06187f0938744bee5a34abe86ce656d2'
  })

  depends_on 'python3' => :logical

  no_source_build
end
