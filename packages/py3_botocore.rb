require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.62-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15c53fc573e43af8ea8ca898b756f60629f4b96d0552006637e8d8ed8932f181',
     armv7l: '15c53fc573e43af8ea8ca898b756f60629f4b96d0552006637e8d8ed8932f181',
       i686: 'de1bea1ae2aa453386eeed5dcdcb80d3cdc01bb81712d4d7b23448652b1ac705',
     x86_64: '95bc6433571ad52710aaca52fb7a24ae72fa9893d476f8fc5aa725167681df73'
  })

  depends_on 'python3' => :logical

  no_source_build
end
