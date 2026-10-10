require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version "1.11.0-#{CREW_PY_VER}"
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74c257216a9df8e37b13aabecf0ed2d50891fed1ced5c7412a6790c17dea2292',
     armv7l: '74c257216a9df8e37b13aabecf0ed2d50891fed1ced5c7412a6790c17dea2292',
       i686: 'bfcf3681ed7b5b35e63b51eef1277de7d8fa753466be3a56838fe2fbae7edd8f',
     x86_64: '2a894e26be72e0ff4df689601189ae3bb7bd6296717a3fc45f03b3900febecaa'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
