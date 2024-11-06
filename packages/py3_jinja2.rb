require 'buildsystems/pip'

class Py3_jinja2 < Pip
  description 'Jinja2 is a very fast and expressive template engine.'
  homepage 'https://jinja.palletsprojects.com/'
  version "3.1.4-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '208131a133ba455a67689af15845ce85c8a6038345d5dd6573db8ca3743afbbf',
     armv7l: '208131a133ba455a67689af15845ce85c8a6038345d5dd6573db8ca3743afbbf',
       i686: 'cbb60608809ac861e67cd9ed2ae821ddf31d4f4a33928ab89cdbbbfb16891291',
     x86_64: '43fd734b610fdb60df52b252e6408af1d1d7c57174081a3f2a26d52ae2f81cce'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
