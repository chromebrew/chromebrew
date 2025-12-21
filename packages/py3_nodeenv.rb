require 'buildsystems/pip'

class Py3_nodeenv < Pip
  description 'Tool to create isolated node.js environments.'
  homepage 'https://github.com/ekalinin/nodeenv'
  version "1.10.0-#{CREW_PY_VER}"
  license 'Copyright (c) 2011, Eugene Kalinin'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec353a24f7e961c892cbaf64cd8e882a1543b5dddd42fb2fe923a03358614b01',
     armv7l: 'ec353a24f7e961c892cbaf64cd8e882a1543b5dddd42fb2fe923a03358614b01',
       i686: '208295abc6e021699f1c541e742a67d0f220969165d98f6a78726091bba38696',
     x86_64: 'd51dba5ec6da37b19ba825d4c1047f863200ada87f822652221486b81c88117c'
  })

  depends_on 'python3'

  no_source_build
end
