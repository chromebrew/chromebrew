require 'buildsystems/pip'

class Py3_pytimeparse < Pip
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  version "1.1.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a03c8587beca6772df2d1ab76bf08e6bd742a4f4e44b15210291615a110ac26',
     armv7l: '4a03c8587beca6772df2d1ab76bf08e6bd742a4f4e44b15210291615a110ac26',
       i686: 'd3b0259c497475d20cb2e5085caa82e308bd0805b0e9cb6232603ad78488dcad',
     x86_64: '9b4d88014abb72ed400df33610e6832ba3aaafd559ef45f1018482710533621c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
