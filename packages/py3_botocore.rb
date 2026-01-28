require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.36-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '164d8add7ec372b4583f9727da80cda7e897bff32e84c609e30b74a14f9ef5ab',
     armv7l: '164d8add7ec372b4583f9727da80cda7e897bff32e84c609e30b74a14f9ef5ab',
       i686: '2e81e9f3759f72f98613c5932d8dbedfb997ce501d732a2c69a268a88a642c5c',
     x86_64: '1d234a80ab12d9a930454599deda2284bc66fbe6b127d290830b667d09ca6886'
  })

  depends_on 'python3' => :build

  no_source_build
end
