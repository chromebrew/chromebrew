require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "0.13.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eca7850b0613956a6a5913c34362c592efe1966e11e32f18c378206b5a417b82',
     armv7l: 'eca7850b0613956a6a5913c34362c592efe1966e11e32f18c378206b5a417b82',
       i686: 'b624046dca0a8052937809046e02f42e524170e3072a88d0dddb3dd54ca9122c',
     x86_64: '2231c13c9babed4035caad9599bb742380fbf4379e1e7970f6c65ead2795885e'
  })

  depends_on 'python3' => :build

  no_source_build
end
