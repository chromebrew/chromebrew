require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.10-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4960a481a92616de52ddc065f6072d3ce7ce2fe724a6f8a554ef78bb753fdfdd',
     armv7l: '4960a481a92616de52ddc065f6072d3ce7ce2fe724a6f8a554ef78bb753fdfdd',
       i686: '15e0d05fb310a0a9d27fb69bc23b260690cb4d4edbb03135dad5744f272e80d7',
     x86_64: '5929a7a161f0b7bf6d21526f8a33cfbb594092ea48d277c133898237dd6726c4'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
