require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.24.2-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb7be91ba076d65fea72ffdf87c5ba4d762a8ca40cc96a939d66c12d81c3c4e1',
     armv7l: 'eb7be91ba076d65fea72ffdf87c5ba4d762a8ca40cc96a939d66c12d81c3c4e1',
       i686: '337484c84dcbfdf4b79f4a7a366f54a5b4e37d3fbd356bb73f542c8a45300a72',
     x86_64: '3aceeba402ab99bb373254329338f6172566d2f7146f067f2a658979add53d7c'
  })

  depends_on 'python3' => :build

  no_source_build
end
