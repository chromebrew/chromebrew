require 'buildsystems/pip'

class Py3_argparse_manpage < Pip
  description 'Automatically build man-pages for your Python project.'
  homepage 'https://github.com/praiskup/argparse-manpage'
  version "4.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d40be600a62e42fc720c24be000f1ee776d275fc2d846e7461e5c16727bf139',
     armv7l: '4d40be600a62e42fc720c24be000f1ee776d275fc2d846e7461e5c16727bf139',
       i686: '421b8f031e10625b6762055320daf076c2617bf6f402296c2b5636e66c753c43',
     x86_64: 'edc6319e8d339aaffe9a0f84cab3098d8387b44dbba961579a89960b7a405229'
  })

  depends_on 'python3'

  no_source_build
end
