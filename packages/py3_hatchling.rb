require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.30.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f70180ad3d8ca8ab29c0efcbf861beaf35f7dfa11f52ac95e1b56822f780a13',
     armv7l: '0f70180ad3d8ca8ab29c0efcbf861beaf35f7dfa11f52ac95e1b56822f780a13',
       i686: '14590c41382627c252e72dcd0a400f5bc5c42322663a4e6bdcc80127a3a970a5',
     x86_64: '3c919957255b8c887210df621ce4d05a3460cd720101b24ac5d62b1909f75499'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :logical

  no_source_build
end
