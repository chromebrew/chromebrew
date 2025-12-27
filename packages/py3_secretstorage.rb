require 'buildsystems/pip'

class Py3_secretstorage < Pip
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  version "3.5.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7cdad209a82403ba59b589913c9a82abaebacb740e684df52a61772a3f52dd0f',
     armv7l: '7cdad209a82403ba59b589913c9a82abaebacb740e684df52a61772a3f52dd0f',
       i686: 'bcbd502e657ea8263bab47f1381c8b87a9fb3a644dc57da1093ab8726f223d6f',
     x86_64: '950429062f49cdeb1b5039606e327f755871581f3ff614211475eb90bb729f32'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build

  no_source_build
end
