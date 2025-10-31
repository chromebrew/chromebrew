require 'buildsystems/pip'

class Py3_pygments < Pip
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version "2.19.2-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a90f4481467f54f6f69c8d81001187b4c4f8c28306e5ca00776c5f8cc9c406ff',
     armv7l: 'a90f4481467f54f6f69c8d81001187b4c4f8c28306e5ca00776c5f8cc9c406ff',
       i686: '8ca58219750fe5271285080685aca12af1409a8c14330f3f77fadd931ee2ac97',
     x86_64: 'dd3b1588d03a1873dcc5c64a5a8f96c611b535623ea573b8304d14049de91b50'
  })

  depends_on 'python3' => :build

  no_source_build
end
