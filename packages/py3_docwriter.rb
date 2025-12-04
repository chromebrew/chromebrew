require 'buildsystems/pip'

class Py3_docwriter < Pip
  description 'API documentation generator of the FreeType library.'
  homepage 'https://gitlab.freedesktop.org/freetype/docwriter'
  version "1.3.3-#{CREW_PY_VER}"
  license 'FTL and GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0773f1cc1dcc84f137c98b60b582d9d7444f4dd0799947137b6d9b1aa1d7aab4',
     armv7l: '0773f1cc1dcc84f137c98b60b582d9d7444f4dd0799947137b6d9b1aa1d7aab4',
       i686: 'febca9dfa7ab5c01b88c6b12e12201066cb9febdc192a410509f423df04d125b',
     x86_64: '071daa228e1182d6e52a3b9fbc9ab8573043b717235eb717ae5f9822f56e5744'
  })

  depends_on 'python3' => :build

  no_source_build
end
