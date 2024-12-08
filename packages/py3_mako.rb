require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.3.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56555446b78f3b62a62fa7f540c9feaf06fa4cab61ae425ec7e4dbb7d57f4af4',
     armv7l: '56555446b78f3b62a62fa7f540c9feaf06fa4cab61ae425ec7e4dbb7d57f4af4',
       i686: '755ccb9d1bc4bdfa3c040c63ee676a5df997a50eb09969dff4a778e3c8fd05d2',
     x86_64: '27a69a779929a48ef31dc7f59208037c0af315d9dbb136187de7f09eccd49165'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
