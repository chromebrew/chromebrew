require 'buildsystems/pip'

class Py3_cssselect < Pip
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  version "1.4.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4127dbc8e30199c4b666b71d0241ec3e479cb5517f1007ab43084872233a730b',
     armv7l: '4127dbc8e30199c4b666b71d0241ec3e479cb5517f1007ab43084872233a730b',
       i686: 'bf9b6354591cc42706dba799ae8a9463fb049b9f2dc5811b36c47d41ea3d133e',
     x86_64: '4dba7a388b1772cd679bbf186185368ab9660d8efc32aba38395d3c129783597'
  })

  depends_on 'python3' => :build

  no_source_build
end
