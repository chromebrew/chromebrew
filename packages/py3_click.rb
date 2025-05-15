require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.2.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b232f3618ab6b48bd0477138baac8e8185cc761e51d46730608eeb1be42c475d',
     armv7l: 'b232f3618ab6b48bd0477138baac8e8185cc761e51d46730608eeb1be42c475d',
       i686: '006e9b6ba77331b2aefe16b0f5d35403e43b12031af5e322ece255c8928dd864',
     x86_64: 'a12c66b8b28eb4099e281a640c3981bf83ef17b502eedcebb74393ce66a5e242'
  })

  depends_on 'python3' => :build

  no_source_build
end
