require 'buildsystems/pip'

class Py3_gvdb < Pip
  description 'Python client for GVDB distributed vector database'
  homepage 'https://github.com/JonathanBerhe/gvdb'
  version "0.38.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d049714fa5028829b7d9552699affa7a885025fc631b90756c3d01edf1c6447',
     armv7l: '4d049714fa5028829b7d9552699affa7a885025fc631b90756c3d01edf1c6447',
       i686: '509084a12f7bd8587b6c4ec74eab676ad36423fb423d60cd0d60c5706b16fa75',
     x86_64: '5918c765c327c0b5e959b47ec9e786a6cde85601f4706e793f9fe6affcd9bea3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
