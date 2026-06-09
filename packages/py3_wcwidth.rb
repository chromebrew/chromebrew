require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.8.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85ccea84af273113dd651596843d35d3b88d8805558add76779c2ef8ef912524',
     armv7l: '85ccea84af273113dd651596843d35d3b88d8805558add76779c2ef8ef912524',
       i686: 'e72585ed00221cbacfcb6f876054065c75c7641ce634b30f58b39c66d0968ea3',
     x86_64: 'e53ceb01539edf91d93ee78c6fea7b818b2a0a7a27e503361cbf15c4d525a4fb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
