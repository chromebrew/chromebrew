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
    aarch64: '7331103dcb8066a6fe478b806178c834501874518f5349738745b03e604216a2',
     armv7l: '7331103dcb8066a6fe478b806178c834501874518f5349738745b03e604216a2',
       i686: '3f10860fb4729502b07bedbb45480fa205b632909f565fc83dccbd6db18e96ff',
     x86_64: '434850191781215f4440e79a33021da5d48ddcbb82093f0e9b4dea097a36903b'
  })

  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' # R

  no_source_build
end
