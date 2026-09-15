require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.3.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c68d3f7275559703b97f87b41351c0776409874153e152e1e9219b5acbfd3889',
     armv7l: 'c68d3f7275559703b97f87b41351c0776409874153e152e1e9219b5acbfd3889',
       i686: 'f5743786b8240d943e39fdb14634a909148dc7c73c7bffee0401b76110229cd8',
     x86_64: 'ad7f865c16d08647d68b2fc493a66d0722032722e2cb36acd62b58eb194fc255'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
