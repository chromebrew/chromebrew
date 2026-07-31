require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.10.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4bf480ab3b14e9c3d7fc1b4908f67690162c77df781c8f9f8592d9baa21eddfb',
     armv7l: '4bf480ab3b14e9c3d7fc1b4908f67690162c77df781c8f9f8592d9baa21eddfb',
       i686: 'c5f2074ac4d4c4d293f8c3bca997f97b0547a456afac857a356c6894d5fcbe28',
     x86_64: '44f7eb6c10e824c2d5055ac919227a5b2a3e456ed29367364a96a35a4b2f3466'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
