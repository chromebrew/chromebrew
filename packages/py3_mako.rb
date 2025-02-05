require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.3.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9af9a1e7ad11ca7e0d05f48ad10e7c954dc0be809152ab60cd4b22d235f3e0b9',
     armv7l: '9af9a1e7ad11ca7e0d05f48ad10e7c954dc0be809152ab60cd4b22d235f3e0b9',
       i686: 'da09699fdf8f08ad28d97a38917ee3fdea3eaba80f9d9033f1248405a1ee02aa',
     x86_64: '27a69a779929a48ef31dc7f59208037c0af315d9dbb136187de7f09eccd49165'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
