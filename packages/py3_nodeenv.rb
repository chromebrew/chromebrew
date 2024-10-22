require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version "1.9.1-#{CREW_PY_VER}"
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ed532bde750386d9b73fc8909fb00938eb15d7df1990fac99d3ba9ea8869a35',
     armv7l: '5ed532bde750386d9b73fc8909fb00938eb15d7df1990fac99d3ba9ea8869a35',
       i686: '479cfbf1bcf940b6ffd3a15449549ade6484309cd8258a2318b4020002d9f4dd',
     x86_64: '5aa2efb4274126fd31e1f8555659cbe0c1e4c30261efdcaa1ffe90018e4569dc'
  })

  depends_on 'python3'

  no_source_build
end
