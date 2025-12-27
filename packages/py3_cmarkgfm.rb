require 'buildsystems/pip'

class Py3_cmarkgfm < Pip
  description 'Python bindings to GitHub\'s cmark.'
  homepage 'https://github.com/theacodes/cmarkgfm'
  version "2025.10.22-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '011da5478bc57464a2641e1f6e524ab6e61c480d2fb2aa92262f53f092c0df49',
     armv7l: '011da5478bc57464a2641e1f6e524ab6e61c480d2fb2aa92262f53f092c0df49',
       i686: '3f10860fb4729502b07bedbb45480fa205b632909f565fc83dccbd6db18e96ff',
     x86_64: 'a56a8db15f0d19d910d6059dda509a320c645f8c53a216ceb1eea91a5b762d80'
  })

  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' # R

  no_source_build
end
