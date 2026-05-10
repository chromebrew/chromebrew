require 'buildsystems/pip'

class Py3_gvdb < Pip
  description 'Python client for GVDB distributed vector database'
  homepage 'https://github.com/JonathanBerhe/gvdb'
  version "0.32.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ede5a2447bcba766814c3d154e4f12b24bcefae28c99d1b514a9eae949137664',
     armv7l: 'ede5a2447bcba766814c3d154e4f12b24bcefae28c99d1b514a9eae949137664',
       i686: 'f4b51a72fc0a7be4b5258471ad27e21677531ed8963e7e6cbf04d1892a11aa84',
     x86_64: 'bc6d495e34a13ffa9aa67d2c87553bbbd055c0b06317577dd733d57edf64484a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
