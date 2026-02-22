require 'buildsystems/pip'

class Py3_wstools < Pip
  description 'WSDL parsing services package for Web Services for Python.'
  homepage 'https://github.com/pycontribs/wstools'
  version "0.4.8-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f8d1697ef5faeb88404b6410bd339797953ac7014e8db985585da76f1f80249',
     armv7l: '4f8d1697ef5faeb88404b6410bd339797953ac7014e8db985585da76f1f80249',
       i686: '5065e68eebbb411e780a53292d3225c2ad3dcff8d8c73b50a46236578ffbd69d',
     x86_64: 'f10586fe6014995c80bdbb48e965d902a526744bd87f6f72caeffd489c41e4a0'
  })

  depends_on 'python3' => :build

  no_source_build
end
