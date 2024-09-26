require 'buildsystems/pip'

class Py3_pyasn1 < Pip
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  version "0.6.1-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e80820dcc2793e927877af1fffc09263129dcddbd104c2016d42749bfbbe8f0c',
     armv7l: 'e80820dcc2793e927877af1fffc09263129dcddbd104c2016d42749bfbbe8f0c',
       i686: 'a2e83f76caaa235ba4ec8125830dcafe0401a4654ada22831ddf5561671b3ae4',
     x86_64: '8433dee0e95767d3428b314bf2857fa0e7c12fae74e109f2dedec06c12a59e3c'
  })

  depends_on 'python3' => :build

  no_source_build
end
