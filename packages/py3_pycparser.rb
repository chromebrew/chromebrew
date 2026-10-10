require 'buildsystems/pip'

class Py3_pycparser < Pip
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  version "3.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '972f30011114f3b2ffb3331524bfb6f7dd3f1d8df2dbe0fa214d45ca946587bb',
     armv7l: '972f30011114f3b2ffb3331524bfb6f7dd3f1d8df2dbe0fa214d45ca946587bb',
       i686: 'faef17462c8228b9f099543b2b1cf6d002790ef40050cfa4bd3b8e98b121febb',
     x86_64: '60889ac776a92204bea34c94b5fb10e4a6024f400aa8aba19079cd11ab20ba19'
  })

  depends_on 'python3' => :logical

  no_source_build
end
