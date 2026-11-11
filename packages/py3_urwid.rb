require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "5.1.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '915ac234815c01308f9902f23b58345912f5954e73e2bf7e0d1bdafe2991dd0a',
     armv7l: '915ac234815c01308f9902f23b58345912f5954e73e2bf7e0d1bdafe2991dd0a',
       i686: '82996c6c28b23f1b38f349cc1bf9d37ec9c0d241d2565fef44c22781d1e332f6',
     x86_64: '8aabb75ab7128ca65c6c324334382229be9502fe3356b11b10dbd987e527b1a6'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
