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
    aarch64: 'e41ffdef1f094f4996cde616b8176c367763e1ec0c5bb75029e11422e5b14ad9',
     armv7l: 'e41ffdef1f094f4996cde616b8176c367763e1ec0c5bb75029e11422e5b14ad9',
       i686: '14e27c0290aa75b16fcff04638812c39bbb8198f0a9c0cbe2c766254667718f6',
     x86_64: '5759cbc7a9e330cb9d52b17286f92fcd340c3b7fe16e6ba4c661289e0e88030e'
  })

  depends_on 'python3' => :build

  no_source_build
end
